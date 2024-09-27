package com.example.mobilelibraryjava.ApiResponse;
import com.fasterxml.jackson.annotation.JsonProperty;


enum HttpStatus {
    OK(200, "成功"),
    CREATED(201, "已创建"),
    ACCEPTED(202, "已接受"),
    NO_CONTENT(204, "无内容"),
    BAD_REQUEST(400, "请求无效"),
    UNAUTHORIZED(401, "未授权"),
    FORBIDDEN(403, "禁止访问"),
    NOT_FOUND(404, "未找到"),
    INTERNAL_SERVER_ERROR(500, "服务器内部错误"),
    SERVICE_UNAVAILABLE(503, "服务不可用");

    private final int statusCode;
    private final String description;

    HttpStatus(int statusCode, String description) {
        this.statusCode = statusCode;
        this.description = description;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public String getDescription() {
        return description;
    }
}


// 响应的通用结构
public class ApiResponse {
    @JsonProperty("message")
    private String message;

    @JsonProperty("code")
    private int code;

    @JsonProperty("Data")
    private Object data; // 这里使用Object，因为Data可能是数组或字典


    @JsonProperty("status")
    // 添加私有成员变量status
    private HttpStatus status;



    public HttpStatus getStatus() {
        return status;
    }

    public void setStatus(HttpStatus status) {
        this.status = status;
    }
    // 构造器、getter和setter方法
    public ApiResponse(String message, int code, Object data) {
        this.message = message;
        this.code = code;
        this.data = data;
    }



}
