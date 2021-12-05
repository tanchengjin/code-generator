<#assign methodPackageRoot="com.tanchengjin.generatorcode.core.freemarker.method">
<#--a_b to aB-->
<#assign underscoreToLowerCase = "${methodPackageRoot}.LowerUnderScoreToLowerCamel"?new()>
<#--a_b to AB-->
<#assign underscoreToUpperCase = "${methodPackageRoot}.LowerUnderScoreToUpperCamel"?new()>
<#--serialVersionUID-->
<#assign serialVersionUID = "${methodPackageRoot}.SerialVersionUID"?new()>


<#--类注释 ClassComment("注释描述")-->
<#macro classComment description>
/**
 * create by ${tableInfo.tableNameName!''} ${description}
 *
 * @author ${author!''}
 * @since ${version!''}
 * @version ${version!'v1.0.0'}
 */
</#macro>


<#--get and set-->
<#macro getAndSetMethod fieldList>
<#list fieldList as field>

    public ${field.fieldType.javaType} get${underscoreToUpperCase(field.name)}()
    {
        return this.${underscoreToLowerCase(field.name)};
    }

    public void set${underscoreToUpperCase(field.name)}(${field.fieldType.javaType} ${underscoreToLowerCase(field.name)})
    {
        this.${underscoreToLowerCase(field.name)} = ${underscoreToLowerCase(field.name)};
    }
</#list>
</#macro>