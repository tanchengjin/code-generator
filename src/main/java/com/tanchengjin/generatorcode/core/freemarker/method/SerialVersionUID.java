package com.tanchengjin.generatorcode.core.freemarker.method;

import com.tanchengjin.generatorcode.GeneratorApplication;
import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

import java.io.ObjectStreamClass;
import java.util.List;

public class SerialVersionUID implements TemplateMethodModelEx {

    @Override
    public String exec(List list) throws TemplateModelException {
        long SVUID = 1L;
        Object o = list.get(0);
        ObjectStreamClass lookup = ObjectStreamClass.lookup(o.getClass());
        SVUID = lookup.getSerialVersionUID();
        return String.valueOf(SVUID+"L");
    }
}
