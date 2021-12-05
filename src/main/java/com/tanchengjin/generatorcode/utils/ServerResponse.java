package com.tanchengjin.generatorcode.utils;

import java.io.Serializable;

public class ServerResponse<T> implements Serializable {

    private static final Long serialVersionUID = 1L;

    private int errno;
    private String message;
    private T data;

    private ServerResponse(int errno, String message, T data) {
        this.errno = errno;
        this.message = message;
        this.data = data;
    }

    public static <T> ServerResponse<T> responseWithSuccess() {
        return new ServerResponse<T>(0, "success", null);
    }

    public static <T> ServerResponse<T> responseWithSuccess(String message) {
        return new ServerResponse<T>(0, message, null);
    }

    public static <T> ServerResponse<T> responseWithSuccess(T data) {
        return new ServerResponse<T>(0, "success", data);
    }

    public static <T> ServerResponse<T> responseWithSuccess(T data, String message) {
        return new ServerResponse<T>(0, message, data);
    }


    public static <T> ServerResponse<T> responseWithFailure(int errno, String message, T data) {
        return new ServerResponse<T>(errno, message, data);
    }

    public static <T> ServerResponse<T> responseWithFailureMessage(String message) {
        return new ServerResponse<T>(1, message, null);
    }

    public static <T> ServerResponse<T> responseWithFailure() {
        return new ServerResponse<T>(1, "error", null);
    }

    public int getErrno() {
        return errno;
    }

    public void setErrno(int errno) {
        this.errno = errno;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
