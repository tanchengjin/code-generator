<#include "tools.ftl">
<#assign pk = tableInfo.primaryKeyField>
<#--pojo name-->
<#assign pojoName=underscoreToUpperCase(tableInfo.name)>
<#assign pojoNameLowerCaseCamel = underscoreToLowerCase(tableInfo.name)>
package ${packageName}.service.impl;

import ${packageName}.pojo.${pojoName};
import ${packageName}.dao.${pojoName}Mapper;
import ${packageName}.service.${pojoName}Service;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;

<@classComment description="${tableInfo.tableName} ServiceImpl"></@classComment>
@Service("${pojoNameLowerCaseCamel}Service")
public class ${pojoName}ServiceImpl implements ${pojoName}Service {

    @Autowired
    private ${pojoName}Mapper ${pojoNameLowerCaseCamel}Mapper;

    public ${pojoName} findOneBy${pk.name?cap_first}(${pk.fieldType.rawJavaType} ${pk.name})
    {
        ${pojoName} ${pojoNameLowerCaseCamel} = ${pojoNameLowerCaseCamel}Mapper.selectByPrimaryKey(${pk.name});
        return ${pojoNameLowerCaseCamel};
    }

    public int deleteBy${pk.name?cap_first}(${pk.fieldType.rawJavaType} ${pk.name})
    {
        int i = ${pojoNameLowerCaseCamel}Mapper.deleteByPrimaryKey(${pk.name});
        return i;

    }

    public int create(${pojoName} ${pojoNameLowerCaseCamel})
    {
        int i = ${pojoNameLowerCaseCamel}Mapper.insertSelective(${pojoNameLowerCaseCamel});
        return i;
    }

    public int updateBy${pk.name?cap_first}(${pojoName} ${pojoNameLowerCaseCamel}, ${pk.fieldType.rawJavaType} ${pk.name})
    {
        ${pojoNameLowerCaseCamel}.set${pk.name?cap_first}(id);
        int i = ${pojoNameLowerCaseCamel}Mapper.updateByPrimaryKeySelective(${pojoNameLowerCaseCamel});
        return i;
    }

    public List<${pojoName}> getAll()
    {
        List<${pojoName}> ${pojoNameLowerCaseCamel}List = ${pojoNameLowerCaseCamel}Mapper.getAll();
        return ${pojoNameLowerCaseCamel}List;
    }

    public List<${pojoName}> getAllByCondition(${pojoName} ${pojoNameLowerCaseCamel})
    {
        List<${pojoName}> ${pojoNameLowerCaseCamel}List = ${pojoNameLowerCaseCamel}Mapper.getAllByCondition(${pojoNameLowerCaseCamel});
        return ${pojoNameLowerCaseCamel}List;
    }

    public int batchDelete(${pk.fieldType.rawJavaType}[] ${pk.name}s)
    {
        int i = 0;
        for(${pk.fieldType.rawJavaType} ${pk.name} : ${pk.name}s)
        {
            i+= ${pojoNameLowerCaseCamel}Mapper.deleteByPrimaryKey(${pk.name});
        }
        return i;
    }

    public ${pk.fieldType.rawJavaType} count()
    {
        return ${pojoNameLowerCaseCamel}Mapper.count();
    }
}