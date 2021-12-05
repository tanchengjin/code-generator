package com.tanchengjin.generatorcode.core.config;

/**
 * 模板配置
 */
public class TemplateConfig {
    //模板所在位置
    private String template;

    private String templatePrefix;

    //模板输出后的文件名
    private String targetName;


    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    public String getTemplatePrefix() {
        return templatePrefix;
    }

    public void setTemplatePrefix(String templatePrefix) {
        this.templatePrefix = templatePrefix;
    }

    public String getTargetName() {
        return targetName;
    }

    public void setTargetName(String targetName) {
        this.targetName = targetName;
    }
}
