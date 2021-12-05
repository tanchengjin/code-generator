package com.tanchengjin.generatorcode.core.freemarker.method;

import com.google.common.base.CaseFormat;
import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

import java.util.List;

//a_b to aB
public class LowerUnderScoreToLowerCamel implements TemplateMethodModelEx {

    @Override
    public String exec(List args) throws TemplateModelException {
        if (args == null) return "";
        String o = String.valueOf(args.get(0));
        if (o.isEmpty()) return o;
        return CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, o);
    }
}
