<#include "tools.ftl">
<#include "tools/LAY.ftl">
<#assign htmlElement = "">
<#assign tName = tableInfo.name?replace("_","-")>
<#--表格-->
<#assign LAYManager="LAY-"+tName+"-manager">
<#--talbe 工具栏-->
<#assign LAYToolbar="table-"+tName+"-toolbar">
<#--提交按钮-->
<#assign LAYSubmit="LAY-"+tName+"-submit">
<#--搜索ID-->
<#assign LAYSearch="LAY-"+tName+"-search">
<#assign ajaxContentType="application/json;charset=UTF-8">
<#assign recordName=tableInfo.comment!'记录'>
<#if (!tableInfo.comment??) || tableInfo.comment == "">
<#assign recordName="记录">
</#if>
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="utf-8">
    <title>${tableInfo.comment!'list'}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="/static/layuiadmin/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">

                <#list tableInfo.fieldList as field>
                    <#if field.fieldType.javaType != "Date" && field.fieldType.javaType != "DateTime" && field.fieldType.javaType != "Timestamp">
                        <div class="layui-inline">
                            <label class="layui-form-label"><#if (!field.comment??) || (field.comment == "")>${field.name}<#else >${field.comment}</#if> </label>
                            <div class="layui-input-block">
                                <input type="text" name="${underscoreToLowerCase(field.name)}" placeholder="请输入" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                        <@getTplBlockByField field=field></@getTplBlockByField>
                    </#if>
                </#list>

                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-admin" lay-submit lay-filter="${LAYSearch}">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-admin" data-type="batchdel">删除</button>

                <button class="layui-btn layuiadmin-btn-admin" data-type="add">添加</button>
            </div>

            <table id="${LAYManager}" lay-filter="${LAYManager}"></table>

<#--            <script type="text/html" id="switchTpl">-->
<#--                {{#  if(d.enable == true){ }}-->
<#--                <button class="layui-btn layui-btn-xs">可用</button>-->
<#--                {{#  } else { }}-->
<#--                <button class="layui-btn layui-btn-primary layui-btn-xs">禁用</button>-->
<#--                {{#  } }}-->
<#--            </script>-->

            <script type="text/html" id="${LAYToolbar}">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                            class="layui-icon layui-icon-edit"></i>编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                            class="layui-icon layui-icon-delete"></i>删除</a>
            </script>
        </div>
    </div>
</div>

<script src="/static/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '/static/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table', 'form'], function () {
        var $ = layui.$,
            form = layui.form,
            table = layui.table;


        var t = layui.$, i = layui.table;

        i.render({
            elem: "#${LAYManager}",
            url: "list",
            cols: [[
                {type: "checkbox", fixed: "left"},
                <#list tableInfo.fieldList as field>
                <#if field.name == "id">
                {field: "id", width: 80, title: "ID", sort: true},
                <#else >
                {field: "${underscoreToLowerCase(field.name)}",title: "<#if (field.comment??) && (field.comment != "")>${field.comment}<#else >${field.name?upper_case}</#if>",width: "",sort: "",templet: "<@LAYTemplet field=field></@LAYTemplet>",align: "center"},
                </#if>
                </#list>
                {title: "操作", width: 150, align: "center", fixed: "right", toolbar: "#${LAYToolbar}"}
                <#--        #if(${column.shortType} == "Boolean" || ${column.shortType} == "boolean")templet:"#switchTpl", minWidth:80, align:"center"#end, sort:true},#end#end-->
            ]],
            text: "对不起，加载出现异常！",
            page:true,
            limit:30,
            loading:true
        }),
            i.on("tool(${LAYManager})", function (e) {
                e.data;
                if ("del" === e.event) layer.confirm("确定删除此${recordName}？", function (t) {
                    let id = e.data.id;
                    $.ajax({
                        beforeSend:function (xhr, settings) {
                            xhr.setRequestHeader('${r"${(_csrf.headerName)!''}"}',"${r"${(_csrf.token)!''}"}");
                        },
                        method: "DELETE",
                        url: id,
                        data: {},
                        dataType: "json",
                        success: function (res) {
                            if (res.errno === 0) {
                                e.del();
                                layer.close(t);

                                // layer.close(index);
                                // table.reload('${LAYManager}');
                                // layer.msg('已删除');
                            } else {
                                layer.msg(res.message)
                            }
                        },
                        error: function (error) {
                        },
                        statusCode: {
                            404: function () {
                            },
                            400: function (res) {
                                console.log(res.responseJSON.message)
                            },
                            500: function () {
                            }
                        }
                    }).done(function (d) {
                    });
                }); else if ("edit" === e.event) {
                    t(e.tr);
                    let id = e.data.id;
                    layer.open({
                        type: 2,
                        title: "编辑${recordName}",
                        content: id + "/edit",
                        area: ["420px", "420px"],
                        btn: ["确定", "取消"],
                        maxmin:true,
                    /**
                         * yes - 确定按钮回调方法
                         * 类型：Function，默认：null
                         * @param index 当前层索引
                         * @param dom 前层DOM对象
                         */
                        yes: function (index, dom) {
                            var l = window["layui-layer-iframe" + index];
                            var r = "${LAYSubmit}";
                            var n = dom.find("iframe").contents().find("#" + r);
                            //监听弹出框提交
                            l.layui.form.on("submit(" + r + ")", function (t) {
                                //获取弹出框所有字段
                                let field = t.field;
                                //判断switch空值
                                <#list onSwitchList as sName>
                                if (!field.${sName}) {
                                    field.${sName} = 0;
                                }
                                </#list>
                                $.ajax({
                                    beforeSend:function (xhr, settings) {
                                        xhr.setRequestHeader('${r"${(_csrf.headerName)!''}"}',"${r"${(_csrf.token)!''}"}");
                                    },
                                    method: "PUT",
                                    url: field.id,
                                    contentType:"${ajaxContentType}",
                                    data: JSON.stringify(field),
                                    dataType: "json",
                                    async: true,
                                    cache: true,
                                    success: function (res) {
                                        if (res.errno === 0) {
                                            //关闭当前弹出框
                                            layer.close(index);
                                            //重新table
                                            i.reload("${LAYManager}");
                                        } else {
                                            layer.msg(res.message)
                                        }
                                    },
                                    error: function (error) {
                                    },
                                    statusCode: {
                                        404: function () {
                                        },
                                        400: function (res) {
                                            console.log(res.responseJSON.message)
                                        },
                                        500: function () {
                                        }
                                    }
                                }).done(function (d) {
                                    console.log(d)
                                });
                            });
                            n.trigger("click")
                        },
                        success: function (e, t) {
                        }
                    })
                }
            });


        //监听搜索
        form.on('submit(${LAYSearch})', function (data) {
            var field = data.field;

            //执行重载
            table.reload('${LAYManager}', {
                where: field
            });
        });

        //事件
        var active = {
            //批量删除
            batchdel: function () {
                var checkStatus = table.checkStatus('${LAYManager}')
                    , checkData = checkStatus.data; //得到选中的数据
                if (checkData.length === 0) {
                    return layer.msg('请选择数据');
                }
                layer.confirm('确定删除吗？', function (index) {
                    //获取所有记录id
                    var ids = [];
                    checkData.forEach(function (data, index) {
                        ids.push(data.id);
                    })

                    //执行 Ajax 后重载
                    $.ajax({
                        beforeSend:function (xhr, settings) {
                            xhr.setRequestHeader('${r"${(_csrf.headerName)!''}"}',"${r"${(_csrf.token)!''}"}");
                        },
                        contentType:'${ajaxContentType}',
                        method: "DELETE",
                        url: "batchDelete",
                        data: {
                            ids: ids
                        },
                        dataType: "json",
                        async: true,
                        cache: true,
                        success: function (res) {
                            if (res.errno === 0) {
                                table.reload('${LAYManager}');
                                layer.msg('已删除');
                            } else {
                                layer.msg(res.message);
                            }
                        },
                        error: function (error) {
                        },
                        statusCode: {
                            404: function () {
                            },
                            400: function (res) {
                                console.log(res.responseJSON.message)
                            },
                            500: function () {
                            }
                        }
                    }).done(function (d) {
                        console.log(d)
                    });
                });
            }
            , add: function () {
                layer.open({
                     type: 2,
                     title: '添加${recordName}',
                     content: 'create',
                     area: ['600px', '500px'],
                     btn: ['确定', '取消'],
                     maxmin:true,
                     yes: function (index, layero) {
                        // //获取弹出框的DOM
                        // var othis = layero.find('iframe').contents().find("#layuiadmin-form-admin")
                        // //获取input所有数据
                        // var field = othis.find('input').serializeArray();


                        var iframeWindow = window['layui-layer-iframe' + index];
                        var submitID = '${LAYSubmit}';
                        var submit = layero.find('iframe').contents().find('#' + submitID);

                        //监听提交
                        iframeWindow.layui.form.on('submit(${LAYSubmit})', function (data) {
                            var field = data.field; //获取提交的字段
                            //判断switch空值
                            <#list onSwitchList as sName>
                            if (!field.${sName}) {
                                field.${sName} = 0;
                            }
                            </#list>
                            //提交 Ajax 成功后，静态更新表格中的数据
                            $.ajax({
                                beforeSend:function (xhr, settings) {
                                    xhr.setRequestHeader('${r"${(_csrf.headerName)!''}"}',"${r"${(_csrf.token)!''}"}");
                                },
                                method: "POST",
                                url: "./",
                                <#--url: "/${underscoreToLowerCase(tableInfo.name)}",-->
                                contentType:"${ajaxContentType}",
                                data: JSON.stringify(field),
                                dataType: "json",
                                async: true,
                                cache: true,
                                success: function (res) {
                                    if (res.errno === 0) {
                                        //数据动态刷新
                                        table.reload('${LAYManager}');
                                        layer.close(index); //关闭弹层
                                    } else {
                                        layer.msg(res.message)
                                    }
                                },
                                error: function (error) {
                                },
                                statusCode: {
                                    404: function () {
                                    },
                                    400: function (res) {
                                        console.log(res.responseJSON.message)
                                    },
                                    500: function () {
                                    }
                                }
                            }).done(function (d) {
                                console.log(d)
                            });
                        });

                        submit.trigger('click');
                    }
                });
            }
        }
        $('.layui-btn.layuiadmin-btn-admin').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        <#list onSwitchList as sName>
            form.on('switch(${sName}_switchActive)', function (res) {
                let status = res.elem.checked == true ? 1 : 0;

                let id = $(res.elem).data('id');
                $.ajax({
                    beforeSend:function (xhr, settings) {
                        xhr.setRequestHeader('${r"${(_csrf.headerName)!''}"}',"${r"${(_csrf.token)!''}"}");
                    },
                    contentType:'${ajaxContentType}',
                    method: "PUT",
                    url: id,
                    data: JSON.stringify({
                        id: id,
                        ${sName}: status
                    }),
                    dataType: "json",
                    async: true,
                    cache: true,
                    success: function (res) {
                        if (res.errno === 0) {
                            layer.msg('操作成功')
                        } else {
                            layer.msg('操作失败')
                        }
                    },
                    error: function (error) {
                    },
                });
            });
        </#list>

    });
</script>
</body>
</html>

