<#include "tools.ftl">
<#include "tools/annotation.ftl">
<#assign templatePath="${underscoreToLowerCase(tableInfo.name)}">
<#assign pojoName=underscoreToUpperCase(tableInfo.name)>
<#assign pojoNameLowerCaseCamel = underscoreToLowerCase(tableInfo.name)>
<#assign pk = tableInfo.primaryKeyField>
package ${packageName!''}.controller;
import ${packageName}.pojo.${underscoreToUpperCase(tableInfo.name)};
import ${packageName}.dao.${underscoreToUpperCase(tableInfo.name)}Mapper;
import ${packageName}.service.${underscoreToUpperCase(tableInfo.name)}Service;

import com.github.pagehelper.PageHelper;
import ${packageName!''}.utils.LayuiAdminServerResponse;
import ${packageName!''}.utils.ServerResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;


<@classAnnotation title="${tableInfo.tableName} Controller"></@classAnnotation>
@Controller
@RequestMapping("${underscoreToLowerCase(tableInfo.name)}")
public class ${underscoreToUpperCase(tableInfo.name)}Controller {
    /**
    * Service
    */
    @Autowired
    private ${underscoreToUpperCase(tableInfo.name)}Service ${underscoreToLowerCase(tableInfo.name)}Service;

    /**
    * Mapper
    */
    @Autowired
    private ${underscoreToUpperCase(tableInfo.name)}Mapper ${underscoreToLowerCase(tableInfo.name)}Mapper;



    @GetMapping("/index")
    public String index() {
        return "/${templatePath}/list";
    }

    @RequestMapping(value = "/list", method = {RequestMethod.GET})
    @ResponseBody
    public LayuiAdminServerResponse index(@RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "limit", defaultValue = "10") int limit,${underscoreToUpperCase(tableInfo.name)} ${underscoreToLowerCase(tableInfo.name)}) {
        PageHelper.startPage(page, limit);
        List<${underscoreToUpperCase(tableInfo.name)}> ${underscoreToLowerCase(tableInfo.name)}List = ${underscoreToLowerCase(tableInfo.name)}Service.getAllByCondition(${underscoreToLowerCase(tableInfo.name)});

        long count = ${underscoreToLowerCase(tableInfo.name)}Service.count();
        return LayuiAdminServerResponse.responseWithSuccess(${underscoreToLowerCase(tableInfo.name)}List, String.valueOf(count));
    }

    @RequestMapping(value = "/create", method = {RequestMethod.GET})
    public String create(Model view) {
        return "/${templatePath}/add";
    }

    /**
    * <p>
    *   POST http://www.example.com HTTP/1.1
    *   Content-Type: application/json;charset=UTF-8
    * </p>
    * @return ServerResponse
    */
    @RequestMapping(value = "", method = {RequestMethod.POST})
    @ResponseBody
    public ServerResponse store(@RequestBody ${underscoreToUpperCase(tableInfo.name)} ${underscoreToLowerCase(tableInfo.name)}) {
        int i = ${underscoreToLowerCase(tableInfo.name)}Service.create(${underscoreToLowerCase(tableInfo.name)});
        if (i >= 1) {
            return ServerResponse.responseWithSuccess();
        } else {
            return ServerResponse.responseWithFailureMessage("创建失败请重试");
        }
    }

    /**
    * <p>
    *   POST http://www.example.com HTTP/1.1
    *   Content-Type: application/x-www-form-urlencoded;charset=UTF-8
    * </p>
    * @return ServerResponse
    */
    @RequestMapping(value = "/submit", method = {RequestMethod.POST})
    @ResponseBody
    public ServerResponse submit(${underscoreToUpperCase(tableInfo.name)} ${underscoreToLowerCase(tableInfo.name)}) {
        int i = ${underscoreToLowerCase(tableInfo.name)}Service.create(${underscoreToLowerCase(tableInfo.name)});
        if (i >= 1) {
            return ServerResponse.responseWithSuccess();
        } else {
            return ServerResponse.responseWithFailureMessage("创建失败请重试");
        }
    }

    @RequestMapping(value = "/{id}", method = {RequestMethod.GET})
    @ResponseBody
    public ServerResponse<${underscoreToUpperCase(tableInfo.name)}> show(@PathVariable("id") int id) {
    ${underscoreToUpperCase(tableInfo.name)} ${underscoreToLowerCase(tableInfo.name)} = ${underscoreToLowerCase(tableInfo.name)}Service.findOneBy${pk.name?cap_first}(id);
        return ServerResponse.responseWithSuccess(${underscoreToLowerCase(tableInfo.name)});
    }

    @RequestMapping(value = "/{id}/edit", method = {RequestMethod.GET})
    public String edit(Model view, @PathVariable(value = "id") int id) {
    ${underscoreToUpperCase(tableInfo.name)} ${underscoreToLowerCase(tableInfo.name)} = ${underscoreToLowerCase(tableInfo.name)}Service.findOneBy${pk.name?cap_first}(id);
        view.addAttribute("${underscoreToLowerCase(tableInfo.name)}", ${underscoreToLowerCase(tableInfo.name)});
        return "/${templatePath}/edit";
    }

    /**
    * <p>
    *   POST http://www.example.com HTTP/1.1
    *   Content-Type: application/json;charset=UTF-8
    * </p>
    * @return ServerResponse
    */
    @RequestMapping(value = "/{id}", method = {RequestMethod.PUT})
    @ResponseBody
    public ServerResponse update(@RequestBody ${underscoreToUpperCase(tableInfo.name)} ${underscoreToLowerCase(tableInfo.name)}, @PathVariable("id") int id) {
        int i = ${underscoreToLowerCase(tableInfo.name)}Service.updateById(${underscoreToLowerCase(tableInfo.name)}, id);
        if (i >= 1) {
            return ServerResponse.responseWithSuccess();
        } else {
            return ServerResponse.responseWithFailureMessage("更新失败，请重试");
        }
    }

    @RequestMapping(value = "/{id}", method = {RequestMethod.DELETE})
    @ResponseBody
    public ServerResponse destroy(@PathVariable(value = "id") int id) {
        int i = ${underscoreToLowerCase(tableInfo.name)}Service.deleteById(id);

        if (i >= 1) {
            return ServerResponse.responseWithSuccess();
        } else {
            return ServerResponse.responseWithFailureMessage("删除失败请重试");
        }
    }

    @RequestMapping(value = "/batchDelete", method = {RequestMethod.DELETE})
    @ResponseBody
    public ServerResponse batchDelete(@RequestParam(value = "${underscoreToLowerCase(pk.name)}s[]") ${pk.fieldType.rawJavaType}[] ${underscoreToLowerCase(pk.name)}s) {
        int i = ${underscoreToLowerCase(tableInfo.name)}Service.batchDelete(${underscoreToLowerCase(pk.name)}s);
        if (i >= 1) {
            return ServerResponse.responseWithSuccess();
        } else {
            return ServerResponse.responseWithFailureMessage("删除失败请重试");
        }
    }

    /**
    * <p>
    *   POST http://www.example.com HTTP/1.1
    *   Content-Type: application/x-www-form-urlencoded;charset=UTF-8
    * </p>
    * @return ServerResponse
    */
    @RequestMapping(value = "/{id}/change", method = {RequestMethod.PUT})
    @ResponseBody
    public ServerResponse change(${underscoreToUpperCase(tableInfo.name)} ${underscoreToLowerCase(tableInfo.name)}, @PathVariable("id") int id) {
        int i = ${underscoreToLowerCase(tableInfo.name)}Service.updateById(${underscoreToLowerCase(tableInfo.name)}, id);
        if (i >= 1) {
            return ServerResponse.responseWithSuccess();
        } else {
            return ServerResponse.responseWithFailureMessage("更新失败，请重试");
        }
    }
}