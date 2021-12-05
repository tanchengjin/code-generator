package com.tanchengjin.generatorcode.core.model;

import com.tanchengjin.generatorcode.core.config.Configuration;
import com.tanchengjin.generatorcode.core.config.TemplateConfig;

import java.util.ArrayList;

public class ConfigurationModel {
    private static final String javaPath = "/src/main/java";
    //资源文件存储路径
    private static final String resourcePath = "/src/main/resources";

    private static final String packagePath = "/com/tanchengjin/generatorcode/test";

    /**
     * 生成配置
     *
     * @return Configuration
     */
    public static Configuration getConfiguration() {
        Configuration configuration = new Configuration();
        ArrayList<TemplateConfig> templateConfigs = new ArrayList<>();
        templateConfigs.add(getTemplateConfig());
        templateConfigs.add(getTemplateConfigOfLAYAdminServerResponse());
        templateConfigs.add(getTemplateConfigOfLAY_List());
        templateConfigs.add(getTemplateConfigOfLAY_Add());
        templateConfigs.add(getTemplateConfigOfLAY_Edit());
        templateConfigs.add(getTemplateConfigOfLAY_Form());
        templateConfigs.add(getTemplateConfigOfController());
        templateConfigs.add(getTemplateConfigOfPojo());
        templateConfigs.add(getTemplateConfigOf_Service());
        templateConfigs.add(getTemplateConfigOf_ServiceImpl());
        templateConfigs.add(getTemplateConfigOf_Dao());
        templateConfigs.add(getTemplateConfigOf_Mapper());
        //设置所有模板信息
        configuration.setTemplates(templateConfigs);
        return configuration;
    }

    private static TemplateConfig getTemplateConfig() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("ServerResponse.java.ftl");
        templateConfig.setTargetName(javaPath + packagePath + "/utils/ServerResponse.java");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOfLAYAdminServerResponse() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("LayuiAdminServerResponse.html.ftl");
        templateConfig.setTargetName(javaPath + packagePath + "/utils/LayuiAdminServerResponse.java");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOfLAY_List() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("LAY_list.html.ftl");
        templateConfig.setTargetName(resourcePath + "/templates/[]/list.html");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOfLAY_Add() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("LAY_add.html.ftl");
        templateConfig.setTargetName(resourcePath + "/templates/[]/add.html");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOfLAY_Edit() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("LAY_edit.html.ftl");
        templateConfig.setTargetName(resourcePath + "/templates/[]/edit.html");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOfLAY_Form() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("LAY_form.html.ftl");
        templateConfig.setTargetName(resourcePath + "/templates/[]/form.html");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOfController() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("controller.java.ftl");
        templateConfig.setTargetName(javaPath + packagePath + "/controller/[]Controller.java");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOfPojo() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("pojo.java.ftl");
        templateConfig.setTargetName(javaPath + packagePath + "/pojo/[].java");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOf_Service() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("service.java.ftl");
        templateConfig.setTargetName(javaPath + packagePath + "/service/[]Service.java");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOf_ServiceImpl() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("serviceImpl.java.ftl");
        templateConfig.setTargetName(javaPath + packagePath + "/service/impl/[]ServiceImpl.java");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOf_Dao() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("Dao.java.ftl");
        templateConfig.setTargetName(javaPath + packagePath + "/dao/[]Mapper.java");
        return templateConfig;
    }

    private static TemplateConfig getTemplateConfigOf_Mapper() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setTemplate("mapper.xml.ftl");
        templateConfig.setTargetName(resourcePath + "/mappers/[]Mapper.xml");
        return templateConfig;
    }
}
