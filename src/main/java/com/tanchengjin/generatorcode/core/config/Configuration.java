package com.tanchengjin.generatorcode.core.config;

import java.util.List;

/**
 * 总配置
 */
public class Configuration {
    public final String author = "Tanchengjin";

    public final String version = "v1.0.0";

    private List<TemplateConfig> templates;

    public List<TemplateConfig> getTemplates() {
        return templates;
    }

    public void setTemplates(List<TemplateConfig> templates) {
        this.templates = templates;
    }

    public String getAuthor() {
        return author;
    }

    public String getVersion() {
        return version;
    }
}
