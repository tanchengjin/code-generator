<#include "tools.ftl">
<#assign pk = tableInfo.primaryKeyField>
<#--pojo name-->
<#assign pojoName=underscoreToUpperCase(tableInfo.name)>

package ${packageName}.service;

import ${packageName}.pojo.${pojoName};
import java.util.List;

/**
 * ${tableInfo.tableName!''} Service
 *
 * @author ${author!''}
 * @since
 */
public interface ${pojoName}Service{

    ${pojoName} findOneBy${pk.name?cap_first}(${pk.fieldType.rawJavaType} ${pk.name});

    int deleteById(${pk.fieldType.rawJavaType} ${pk.name});

    int create(${pojoName} record);

    int updateById(${pojoName} record,${pk.fieldType.rawJavaType} ${pk.name});

    List<${pojoName}>getAll();

    List<${pojoName}>getAllByCondition(${pojoName} condition);

    int batchDelete(${pk.fieldType.rawJavaType}[] ${pk.name}s);

    ${pk.fieldType.rawJavaType} count();
}