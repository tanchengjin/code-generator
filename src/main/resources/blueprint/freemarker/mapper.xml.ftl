<#include "mybatisTool.ftl">
<#include "tools.ftl">
<#--pojo name-->
<#assign pojoName=underscoreToUpperCase(tableInfo.name)>
<#assign pojoNameLowerCaseCamel = underscoreToLowerCase(tableInfo.name)>
<#assign pojoLocation=packageName+".pojo."+pojoName>
<#assign pk = tableInfo.primaryKeyField>
<#assign tableName=tableInfo.tableName>
<#assign longvarcharList=[]>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.dao.${pojoName}Mapper">

    <resultMap type="${packageName}.pojo.${pojoName}" id="BaseResultMap">
        <#list tableInfo.fieldList as field>
            <#if field.fieldType.jdbcType == 'LONGVARCHAR'>
                <#assign longvarcharList=longvarcharList+[field]>
            <#else>
                <result column="${field.name}" jdbcType="${field.fieldType.jdbcType}"
                        property="${underscoreToLowerCase(field.name)}"/>
            </#if>
        </#list>
    </resultMap>

    <#--longvarchar单独引用-->
    <#if (longvarcharList?size >=1)>
        <#list longvarcharList as fld>
            <resultMap extends="BaseResultMap" id="ResultMapWithBLOBs" type="${packageName}.pojo.${pojoName}">
                <result column="${fld.name}" jdbcType="${fld.fieldType.jdbcType}" property="${underscoreToLowerCase(fld.name)}"/>
            </resultMap>
        </#list>
    </#if>

    <sql id="Base_Column_List">
        <@allColumn columns=tableInfo.fieldList></@allColumn>
    </sql>

    <#if (longvarcharList?size>=1)>
        <sql id="Blob_Column_List">
            <@blobAllColumn columns=longvarcharList></@blobAllColumn>
        </sql>
    </#if>

    <select id="selectByPrimaryKey" parameterType="${pk.fieldType.rawJavaType}" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/><#if (longvarcharList?size>=1)>,<include refid="Blob_Column_List"/></#if>
        from ${tableName}
        where ${pk.name} = ${r'#{'+pk.name+',jdbcType='+pk.fieldType.jdbcType+'}'}
    </select>


    <delete id="deleteByPrimaryKey" parameterType="${pk.fieldType.rawJavaType}">
        delete from ${tableName} where ${pk.name} = ${r'#{'+pk.name+',jdbcType='+pk.fieldType.jdbcType+'}'}
    </delete>


    <insert id="insert" parameterType="${pojoLocation}"
            useGeneratedKeys="true" keyProperty="${underscoreToLowerCase(pk.name)}">
        insert into ${tableName} (<@allColumn columns=tableInfo.fieldList></@allColumn>)
        values(<@allValue columns=tableInfo.fieldList></@allValue>)
    </insert>


    <insert id="insertSelective" parameterType="${pojoLocation}"
            useGeneratedKeys="true" keyProperty="${pk.name}">
        insert into ${tableInfo.tableName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
<#list tableInfo.fieldList as field>
    <if test="${underscoreToLowerCase(field.name)} != null">
    <@checkReserve colume=field.name></@checkReserve>,
    </if>
</#list>
        </trim>


        <trim prefix="values (" suffix=")" suffixOverrides=",">
<#list tableInfo.fieldList as field>
    <if test="${underscoreToLowerCase(field.name)} != null">
        ${r'#{'+underscoreToLowerCase(field.name)+',jdbcType='+field.fieldType.jdbcType+'}'},
    </if>
</#list>
        </trim>


    </insert>

    <update id="updateByPrimaryKeySelective" parameterType="${pojoLocation}">
        update ${tableName}
        <set>
<#list tableInfo.fieldList as field>
    <if test="${underscoreToLowerCase(field.name)} != null">


        <@checkReserve colume=field.name></@checkReserve> = ${r'#{'+underscoreToLowerCase(field.name)+',jdbcType='+field.fieldType.jdbcType+'}'},
    </if>
</#list>

        </set>
        where ${pk.name} = ${r'#{'+underscoreToLowerCase(pk.name)+',jdbcType='+pk.fieldType.jdbcType+'}'}
    </update>

    <update id="updateByPrimaryKey" parameterType="${pojoLocation}">
        update ${tableName}

        set <@allSetColumn columns=tableInfo.fieldList></@allSetColumn>

        where ${pk.name} = ${r'#{'+underscoreToLowerCase(pk.name)+',jdbcType='+pk.fieldType.jdbcType+'}'}
    </update>

    <select id="count" resultType="${pk.fieldType.rawJavaType}">
        select count(1)from ${tableName}
    </select>

    <select id="getAll" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/><#if (longvarcharList?size>=1)>,<include refid="Blob_Column_List"/></#if>
        from ${tableName}
    </select>

    <select id="getAllByCondition" resultMap="BaseResultMap" parameterType="${pojoLocation}">
        select
        <include refid="Base_Column_List"/><#if (longvarcharList?size>=1)>,<include refid="Blob_Column_List"/></#if>
        from ${tableName}

        <where>
            <#list tableInfo.fieldList as field>

                <if test="${underscoreToLowerCase(field.name)} != null <#if field.fieldType.javaType == "String">and ${underscoreToLowerCase(field.name)} != ''</#if>">
                    <#if field_index !=0> AND </#if> <@checkReserve colume=field.name></@checkReserve> = ${r'#{'+underscoreToLowerCase(field.name)+'}'}
                </if>
            </#list>
        </where>
    </select>

    <delete id="batchDeleteByPrimaryKey">

    </delete>
<#--<insert id="batchInsert" keyProperty="$!pk.name" useGeneratedKeys="true">-->
<#--        insert into $!{tableInfo.obj.name}-->
<#--        (#foreach($column in $tableInfo.otherColumn)$!column.obj.name#if($velocityHasNext), #end#end)-->
<#--        values-->
<#--<foreach collection="entities" item="entity" separator=",">-->
<#--        (#foreach($column in $tableInfo.otherColumn)#{entity.$!{column.name}}#if($velocityHasNext), #end#end)-->
<#--</foreach>-->
<#--</insert>-->
</mapper>
