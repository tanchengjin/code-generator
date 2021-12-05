package com.tanchengjin.generatorcode.core;

import com.tanchengjin.generatorcode.core.entity.TableInfo;

/**
 * 模板变量类
 */
public class TemplateObject {
    public final String author = "TanChengjin";

    public final String version = "v1.0.0";
    //是否开启类注释
    public final boolean classDesc = true;

    private String packageName;

    private TableInfo tableInfo;

    public TableInfo getTableInfo() {
        return tableInfo;
    }

    public void setTableInfo(TableInfo tableInfo) {
        this.tableInfo = tableInfo;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getAuthor() {
        return author;
    }

    public String getVersion() {
        return version;
    }

    public boolean isClassDesc() {
        return classDesc;
    }
}
