package com.tanchengjin.generatorcode.utils;

import com.google.common.base.CaseFormat;

public class StringUtil {
    public static String ToUpperCase(String tableName) {
        return "";
    }

    public static void main(String[] args) {
        String blog_article = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, "articleDDSADD");
        System.out.println(blog_article);
    }
}
