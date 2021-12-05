<#include "tools/LAY.ftl"/>
<#assign dateTimeElement=false>
<#assign tName = tableInfo.name?replace("_","-")>
<#--存储日期时间元素-->
<#assign dateTimeList=[]>
<#--提交按钮-->
<#assign LAYSubmit="LAY-"+tName+"-submit">
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="utf-8">
    <title>${tableInfo.comment}-新增</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css" media="all">
</head>
<body>

<div class="layui-form" lay-filter="layuiadmin-form-role" id="layuiadmin-form-role" style="padding: 20px 30px 0 0;">
    ${r'<#include "form.ftl">'}
    <#list tableInfo.fieldList as field>
        <#--当前name字段名(默认字段名)-->
            <#assign fName=(field.name)>
        <#--当前字段类型-->
            <#assign ft = field.fieldType>
            <#if ft.javaType=="Date">
            <#--日期时间类型-->
                <#assign dateTimeElement = true>
                <#assign dateTimeList = dateTimeList+[field.name?upper_case]>
            <#elseif ft.javaType="String" && ft.length?? && (ft.length >= 200)>
            <#--检测是否为图片-->
                <#if imgTemplet?seq_contains(fName)>
                    <#assign imgUploadList=imgUploadList+[fName]>
                </#if>
            </#if>
    </#list>

<#--    <#include "tools/LAY_form.ftl">-->
<#--    <@getForm schema="add"></@getForm>-->
    <div class="layui-form-item layui-hide">
        <button class="layui-btn" lay-submit lay-filter="${LAYSubmit}" id="${LAYSubmit}">提交</button>
    </div>
</div>

<script src="/static/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '/static/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form'<#if dateTimeElement == true>, 'laydate'</#if> <#if (imgUploadList?size >=1)>,'upload'</#if>], function () {
        var $ = layui.$
            , form = layui.form;
        <#if imgUploadList?size != 0>
            <#list imgUploadList as img>
                var avatar_src = $("#LAY_${img}Src");
                upload.render({
                    url: "${r'${adminPrefix}'}/upload/image",
                    elem: "#LAY_${img}Upload",
                    data:{
                        '${r'${(_csrf.parameterName)!""}'}':'${r'${(_csrf.token)!""}'}'
                    },
                    done: function (t) {
                        0 == t.errno ? avatar_src.val(t.data.src) : e.msg(t.message, {icon: 5})
                    }
                });
                a.events.${img}Preview = function (t) {
                    var i = avatar_src.val();
                    e.photos({photos: {title: "查看头像", data: [{src: i}]}, shade: .01, closeBtn: 1, anim: 5})
                }
            </#list>
        </#if>
        <#if dateTimeElement == true>
        var laydate = layui.laydate;

        <#list dateTimeList as e>
        //日期时间范围
        laydate.render({
            elem: '#${e}',
            //datetime,time,month,year,en
            type: 'datetime',
            //范围
            range: false,
            //公历节日
            calendar: true,
            /**
             *
             * @param value 当前选中日期时间
             * @param date object {"year": 2021,"month": 11,"date": 23,"hours": 0,"minutes": 0,"seconds": 0}
             }
             */
            done: function (value, date) {

            }
        });
        </#list>
        </#if>
    })
</script>
</body>
</html>