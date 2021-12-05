package com.tanchengjin.generatorcode.core.entity;

import java.util.List;

public class TableInfo {
    //去掉表前缀后的table name
    private String name;
    //要去除的表前缀
    private String prefix;
    //full table name
    private String tableName;
    private List<Field> fieldList;
    private String comment;
    private String TableType;
    private String TableCat;
    private String TypeCat;
    private String TypeName;
    private String DDL;
    private String primaryKey;
    private Field primaryKeyField;


    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public List<Field> getFieldList() {
        return fieldList;
    }

    public void setFieldList(List<Field> fieldList) {
        this.fieldList = fieldList;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }


    public String getTableType() {
        return TableType;
    }

    public void setTableType(String tableType) {
        TableType = tableType;
    }

    public String getTableCat() {
        return TableCat;
    }

    public void setTableCat(String tableCat) {
        TableCat = tableCat;
    }

    public String getTypeCat() {
        return TypeCat;
    }

    public void setTypeCat(String typeCat) {
        TypeCat = typeCat;
    }

    public String getTypeName() {
        return TypeName;
    }

    public void setTypeName(String typeName) {
        TypeName = typeName;
    }

    public String getDDL() {
        return DDL;
    }

    public void setDDL(String DDL) {
        this.DDL = DDL;
    }

    public String getPrimaryKey() {
        return primaryKey;
    }

    public void setPrimaryKey(String primaryKey) {
        this.primaryKey = primaryKey;
    }

    public Field getPrimaryKeyField() {
        return primaryKeyField;
    }

    public void setPrimaryKeyField(Field primaryKeyField) {
        this.primaryKeyField = primaryKeyField;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }
}
