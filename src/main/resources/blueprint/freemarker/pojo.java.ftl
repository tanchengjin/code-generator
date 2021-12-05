package ${packageName!''}.pojo;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import java.util.Date;
<#include "tools.ftl">
<#--时间格式-->
<#assign datetimeList=["Date","Timestamp","Datetime"]>
<#assign thisClass="${packageName}."+"${underscoreToUpperCase(tableInfo.name)}.class">
<@classComment description="pojo"></@classComment>
//@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ${underscoreToUpperCase(tableInfo.name)} implements Serializable {

    private static final long serialVersionUID = ${serialVersionUID(thisClass)};

    <#list tableInfo.fieldList as field>
    <#if (field.comment??) && (field.comment != "")>
    /**
     * ${field.comment}
     */
    </#if>
    <#if datetimeList?seq_contains(field.fieldType.javaType)>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    </#if>
    private ${field.fieldType.javaType} ${underscoreToLowerCase(field.name)};
    </#list>

    <@getAndSetMethod fieldList=tableInfo.fieldList></@getAndSetMethod>

}