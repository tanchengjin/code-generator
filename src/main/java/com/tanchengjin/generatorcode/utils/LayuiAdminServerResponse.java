package com.tanchengjin.generatorcode.utils;

import java.io.Serializable;


public class LayuiAdminServerResponse<T> implements Serializable {
    private int code;
    private String count;
    private T data;
    private String msg;


    private LayuiAdminServerResponse(int code, String count, T data, String msg) {
        this.code = code;
        this.count = count;
        this.data = data;
        this.msg = msg;
    }


    public static <T> LayuiAdminServerResponse<T> responseWithSuccess(T data, String count) {
        return new LayuiAdminServerResponse<>(0, count, data, "");
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
