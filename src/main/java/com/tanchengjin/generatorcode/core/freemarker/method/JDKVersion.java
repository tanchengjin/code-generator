package com.tanchengjin.generatorcode.core.freemarker.method;

import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

import java.util.List;

/**
 * @since
 */
public class JDKVersion implements TemplateMethodModelEx {
    @Override
    public String exec(List list) throws TemplateModelException {
        String version = System.getProperty("java.version");
        int i = version.lastIndexOf("_");
        if(i>=1)
        {
            version = version.substring(0, i);
        }
        return "JDK"+version;
    }
}