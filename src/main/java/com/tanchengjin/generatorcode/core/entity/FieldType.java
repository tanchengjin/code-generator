package com.tanchengjin.generatorcode.core.entity;

public class FieldType {
    //jdbc源类型
    private String source;

    private Boolean unsigned;

    private Integer length;

    private String javaType;
    //java.lang.String
    private String fullJavaType;

    //int long boolean...
    private String rawJavaType;

    private String jdbcType;

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public Boolean getUnsigned() {
        return unsigned;
    }

    public void setUnsigned(Boolean unsigned) {
        this.unsigned = unsigned;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public String getJavaType() {
        return javaType;
    }

    public void setJavaType(String javaType) {
        this.javaType = javaType;
    }


    public String getFullJavaType() {
        return fullJavaType;
    }

    public void setFullJavaType(String fullJavaType) {
        this.fullJavaType = fullJavaType;
    }


    public String getRawJavaType() {
        return rawJavaType;
    }

    public void setRawJavaType(String rawJavaType) {
        this.rawJavaType = rawJavaType;
    }

    public String getJdbcType() {
        return jdbcType;
    }

    public void setJdbcType(String jdbcType) {
        this.jdbcType = jdbcType;
    }
}
