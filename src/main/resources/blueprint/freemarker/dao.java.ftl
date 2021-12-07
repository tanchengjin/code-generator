<#include "tools.ftl">
<#include "tools/annotation.ftl">
<#assign pk = tableInfo.primaryKeyField>
<#--pojo name-->
<#assign pojoName=underscoreToUpperCase(tableInfo.name)>
package ${packageName}.dao;

import ${packageName}.pojo.${pojoName};
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

<@classAnnotation title="${tableInfo.tableName}Mapper" ></@classAnnotation>
@Mapper
public interface ${pojoName}Mapper {

    int deleteByPrimaryKey(${pk.fieldType.rawJavaType} ${pk.name});

    int insert(${pojoName} record);

    int insertSelective(${pojoName} record);

    ${pojoName} selectByPrimaryKey(${pk.fieldType.rawJavaType} ${pk.name});

    int updateByPrimaryKeySelective(${pojoName} record);

    int updateByPrimaryKey(${pojoName} record);

    List<${pojoName}> getAll();

    List<${pojoName}> getAllByCondition(${pojoName} condition);

    ${pk.fieldType.rawJavaType} count();

    int batchDeleteByPrimaryKey(${pk.fieldType.rawJavaType}[] ${pk.name}s);

}
