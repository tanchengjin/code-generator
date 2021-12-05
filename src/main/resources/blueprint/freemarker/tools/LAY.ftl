<#--图片格式索引-->
<#assign imgTemplet=["picture","pic","image","img","imgs","images","pics"]>
<#--将图片上传字段保存到此列表-->
<#assign imgUploadList=[]>
<#--切换格式索引-->
<#assign switchTemplet=["enable","switch","lock","unlock","comment","open","commend","top"]>
<#--存储当前已存在的图片字段列表-->
<#assign currentImageFieldNameList=[]>
<#--通过当前字段名、类型获取对应的templet-->
<#macro LAYTemplet field>
    <@compress single_line=true>
        <#if switchTemplet?seq_contains(field.name)>
            #${field.name}_switchTpl
        <#elseif (field.fieldType.javaType??) && ((field.fieldType.javaType == "Boolean") || (field.fieldType.javaType == "Integer" && field.length == 1))>
            #${field.name}_switchTpl
        <#else>
            <#if imgTemplet?seq_contains(field.name)>
                #${field.name}_imgTpl
            </#if>
        </#if>
    </@compress>
</#macro>

<#--lay动态切换 保存对应的列表-->
<#assign onSwitchList=[]/>
<#macro getTplBlockByField field>

    <#if imgTemplet?seq_contains(field.name)>
        <script type="text/html"id="${field.name}_imgTpl">
            <img style="display: inline-block; width: 50%; height: 100%;"src={{d.${field.name} }}>
        </script>
    </#if>

    <#if switchTemplet?seq_contains(field.name)>
        <#assign onSwitchList = onSwitchList+[field.name]>
        <script type="text/html"id="${field.name}_switchTpl">
                <input type="checkbox"name="${field.name}_tpl"lay-filter="${field.name}_switchActive"lay-skin="switch"lay-text="可用|不可用"{{
            d.${field.name}==1?'checked':''}} data-id="{{ d.id }}">
        </script>
    </#if>

    <#if field.name == "label_noemal">
       <script type="text/html"id="${field.name}_switchTpl">
            {{#  if(d.${field.name} ==true){}}
            <button class="layui-btn layui-btn-xs">可用</button>
            {{#  }else{}}
            <button class="layui-btn layui-btn-primary layui-btn-xs">禁用</button>
            {{#  }}}
        </script>
    </#if>
</#macro>

<#--如何是图片则输出图片上传样式-->
<#macro isImage field>
        <div class="layui-input-inline layui-btn-container" style="width: auto;">
            <button type="button" class="layui-btn layui-btn-primary" id="LAY_avatarUpload">
                <i class="layui-icon">&#xe67c;</i>上传图片
            </button>
            <button class="layui-btn layui-btn-primary" layadmin-event="avartatPreview">查看图片
            </button>
        </div>
</#macro>

<#macro LAY_image_upload_form_item value="">
<div class="layui-form-item">
    <label class="layui-form-label">头像</label>
        <div class="layui-input-inline">
            <input name="avatar" lay-verify="required" id="LAY_avatarSrc" placeholder="图片地址" value="http://cdn.layui.com/avatar/168.jpg" class="layui-input">
            </div>
            <div class="layui-input-inline layui-btn-container"style="width: auto;">
            <button type="button"class="layui-btn layui-btn-primary"id="LAY_avatarUpload">
            <i class="layui-icon">&#xe67c;</i>上传图片
        </button>
        <button class="layui-btn layui-btn-primary"layadmin-event="avartatPreview">查看图片</button>
    </div>
</div>
</#macro>