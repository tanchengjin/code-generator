<#include "tools.ftl">
<#assign reserve=["name","desc","name","add","set","sql","comment","status","get","values","resource","source"]/>
<#macro checkReserve colume>
    <@compress single_line=true>
        <#if reserve?seq_contains(colume)>
        `${colume}`
        <#else>
            ${colume}
        </#if>
    </@compress>
</#macro>


<#macro allColumn columns>
    <@compress single_line=true>
        <#list columns as column>
            <#assign x = reserve?seq_contains("${column.name}")?string("`${column.name}`","${column.name}")>
            <#if column_index == 0>${x}<#else>,${x}</#if>
        </#list>
    </@compress>
</#macro>

<#macro allColumnexcludeBlob columns>
    <@compress single_line=true>
        <#list columns as column>
            <#if column.fieldType.jdbcType != "LONGVARCHAR">
                            <#assign x = reserve?seq_contains("${column.name}")?string("`${column.name}`","${column.name}")>
            <#if column_index == 0>${x}<#else>,${x}</#if>
            </#if>
        </#list>
    </@compress>
</#macro>

<#macro blobAllColumn columns>
    <@compress single_line=true>
        <#list columns as c>
            <#if c.fieldType.jdbcType == "LONGVARCHAR">
                <#assign d = reserve?seq_contains("${c.name}")?string("`${c.name}`","${c.name}")>
                <#if c_index == 0>${d}<#else>,${d}</#if>
            </#if>
        </#list>
    </@compress>
</#macro>
<#macro allValue columns>
    <@compress single_line=true>
        <#list columns as field>
            ${r'#{'+underscoreToLowerCase(field.name)+',jdbcType='+field.fieldType.jdbcType+'}'},
        </#list>
    </@compress>
</#macro>

<#macro allSetColumn columns>
    <@compress single_line=true>
        <#list columns as field>
            <#if  !field.primaryKey>
                <@checkReserve colume=field.name></@checkReserve> = ${r'#{'+underscoreToLowerCase(field.name)+',jdbcType='+field.fieldType.jdbcType+'}'}
            </#if>
        </#list>
    </@compress>
</#macro>
