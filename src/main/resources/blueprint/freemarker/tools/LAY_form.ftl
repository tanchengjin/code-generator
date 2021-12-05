<#include "../tools.ftl">
<#include "../tools/LAY.ftl">
<#--存储日期时间元素-->
<#assign dateTimeList=[]>

<#--存储富文本所有字段-->
<#assign ueditorList=[]>
<#--schema(add,edit)-->
<#macro getForm schema>
    <#--csrf-->
    <input type="hidden" name="${r"${(_csrf.parameterName)!''}"}" value="${r"${(_csrf.token)!''}"}">

    <#--公用表单项目-->
    <#list tableInfo.fieldList as field>
        <#if field.name == "id" || field.name == "Id">
            <#continue>
        </#if>
        <#--当前字段类型-->
        <#assign ft = field.fieldType>
        <#--当前name字段名(默认字段名)-->
        <#assign fName=(field.name)>

        <#assign sg="!'">
        <#assign fieldValue="${r'${'+underscoreToLowerCase(tableInfo.name)+'.'+underscoreToLowerCase(field.name)+sg+''}'}">
        <#assign fieldValueForNumeric="${r'${'+underscoreToLowerCase(tableInfo.name)+'.'+underscoreToLowerCase(field.name)+'?c}'}">
        <#if ft.javaType == "Integer" && ft.length == 1>
        <#-- true or false-->
                <div class="layui-form-item">
                    <label class="layui-form-label"><#if !field.comment?? || (field.comment != "")>${field.comment}<#else>${field.name?upper_case}</#if></label>
                    <div class="layui-input-inline">
                        <input type="checkbox" lay-filter="switch" name="${fName}" lay-skin="switch" lay-text="是|否" <#if schema == "edit"> value="${fieldValue}" <#else >value="1"</#if> checked>
                    </div>
                </div>
        <#elseif ft.javaType="String" && ft.length?? && (ft.length >= 200)>
            <#--检测是否为图片-->
            <#if imgTemplet?seq_contains(fName)>
                <#assign imgUploadList=imgUploadList+[fName]>

                <div class="layui-form-item">
                    <label class="layui-form-label required"><#if !field.comment?? || (field.comment != "")>${field.comment}<#else>${field.name?upper_case}</#if></label>
                    <div class="layui-input-inline">
                        <input name="${fName}" lay-verify="required" id="LAY_${fName}Src" placeholder="图片地址"
                               value="<#if schema == "edit">${fieldValue}</#if>"
                               class="layui-input">
                    </div>
                    <div class="layui-input-inline layui-btn-container" style="width: auto;">
                        <button type="button" class="layui-btn layui-btn-primary" id="LAY_${fName}Upload">
                            <i class="layui-icon">&#xe67c;</i>上传图片
                        </button>
                        <button class="layui-btn layui-btn-primary" layadmin-event="${fName}Preview">查看图片
                        </button>
                    </div>
                </div>
                <#else >
                    <div class="layui-form-item">
                        <label class="layui-form-label"><#if !field.comment?? || (field.comment != "")>${field.comment}<#else>${field.name?upper_case}</#if></label>
                        <div class="layui-input-block">
                            <textarea type="text" name="${fName}" lay-verify="<#if !field.nullable>required</#if>" autocomplete="off" class="layui-textarea"><#if schema == "edit">${fieldValue}</#if></textarea>
                        </div>
                    </div>
            </#if>
        <#elseif ft.javaType="String" && (!ft.length??)>
        <#--text类型-->
            <@ueditorText field=field fieldValue=fieldValue fName=fName schema=schema></@ueditorText>

        <#elseif ft.javaType=="Date">
        <#--日期时间类型-->
            <#assign dateTimeElement = true>
            <#assign dateTimeList = dateTimeList+[field.name?upper_case]>
                <div class="layui-form-item">
                    <label class="layui-form-label"><#if !field.comment?? || (field.comment != "")>${field.comment}<#else>${field.name?upper_case}</#if></label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" id="${field.name?upper_case}" placeholder="" name="${fName}" >
                    </div>
                </div>
        <#elseif ft.javaType == "Integer" || ft.javaType == "Long">
                <div class="layui-form-item">
                    <label class="layui-form-label"><#if !field.comment?? || (field.comment != "")>${field.comment}<#else>${field.name?upper_case}</#if></label>
                    <div class="layui-input-block">
                        <input type="text" name="${fName}" placeholder="请输入" autocomplete="off" lay-verify="<#if !field.nullable>required</#if> number" class="layui-input" <#if schema == "edit">value="${fieldValueForNumeric}"</#if>>
                    </div>
                </div>
        <#else >
                <div class="layui-form-item">
                    <label class="layui-form-label"><#if !field.comment?? || (field.comment != "")>${field.comment}<#else>${field.name?upper_case}</#if></label>
                    <div class="layui-input-block">
                        <input type="text" name="${fName}" placeholder="请输入" autocomplete="off" lay-verify="<#if !field.nullable>required</#if>" class="layui-input" <#if schema == "edit">value="${fieldValue}"</#if>>
                    </div>
                </div>
        </#if>
    </#list>
</#macro>


<#macro normalText field fName schema fieldValue>
    <div class="layui-form-item">
        <label class="layui-form-label"><#if !field.comment?? || (field.comment != "")>${field.comment}<#else>${field.name?upper_case}</#if></label>
        <div class="layui-input-block">
            <textarea type="text" name="${fName}" lay-verify="<#if !field.nullable>required</#if>" autocomplete="off" class="layui-textarea"><#if schema == "edit">${fieldValue}</#if></textarea>
        </div>
    </div>
</#macro>

<#--百度ueditor编辑器-->
<#macro ueditorText field fName schema fieldValue>
            <div class="layui-form-item">
                <label class="layui-form-label"><#if !field.comment?? || (field.comment != "")>${field.comment}<#else>${field.name?upper_case}</#if></label>
                <div class="layui-input-inline" style="width: 90%">
                    <script id="${fName}" name="${fName}" type="text/plain" style="width: auto; height: 150px;"></script>
                </div>
            </div>
            <#if ueditorList?size == 0>
                <!-- 配置文件 -->
                <script type="text/javascript" src="/static/ueditor/ueditor.config.js"></script>
                <!-- 编辑器源码文件 -->
                <script type="text/javascript" src="/static/ueditor/ueditor.all.js"></script>
                <!-- language -->
                <script type="text/javascript" src="/static/ueditor/lang/zh-cn/zh-cn.js"></script>
            </#if>
            <#assign ueditorList=ueditorList+[fName]/>

            <!-- 实例化编辑器 -->
            <script type="text/javascript">
                var ue = UE.getEditor('${fName}');
                UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
                UE.Editor.prototype.getActionUrl = function (action) {
                    if (action == 'uploadimage' || action == 'uploadscrawl' || action == 'uploadimage') {
                        //服务端文件上传接口
                        return '/admin/upload/ueditor';
                    } else {
                        return this._bkGetActionUrl.call(this, action);
                    }
                }
            </script>
</#macro>
