package com.example.mobilelibraryjava.bean;


public class BookRecordInfo {

    private int recordId;
    private String recordBookTitle;
    private String recordBookAuthor;
    private String recordBookPress;
    private String recordBookISBN;
    ///借阅人
    private String recordBorrower;
    private String recordBorrowerTime;
    private String recordBackTime;
    private int bookType;
    ///0 是未申请   1 已经申请但是管理员待审核   2 已借阅成功
    private int recordBookState;
    private String userId;
    private String userIphone;
    private String createTime;
    private String updateTime;

    private  String bookInsideCode;
    // Getters and Setters

    public int getRecordId() {
        return recordId;
    }

    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }

    public String getRecordBookTitle() {
        return recordBookTitle;
    }

    public void setRecordBookTitle(String recordBookTitle) {
        this.recordBookTitle = recordBookTitle;
    }

    public String getRecordBookAuthor() {
        return recordBookAuthor;
    }

    public void setRecordBookAuthor(String recordBookAuthor) {
        this.recordBookAuthor = recordBookAuthor;
    }

    public String getRecordBookPress() {
        return recordBookPress;
    }

    public void setRecordBookPress(String recordBookPress) {
        this.recordBookPress = recordBookPress;
    }

    public String getRecordBookISBN() {
        return recordBookISBN;
    }

    public void setRecordBookISBN(String recordBookISBN) {
        this.recordBookISBN = recordBookISBN;
    }

    public String getRecordBorrower() {
        return recordBorrower;
    }

    public void setRecordBorrower(String recordBorrower) {
        this.recordBorrower = recordBorrower;
    }

    public String getRecordBorrowerTime() {
        return recordBorrowerTime;
    }

    public void setRecordBorrowerTime(String recordBorrowerTime) {
        this.recordBorrowerTime = recordBorrowerTime;
    }

    public String getRecordBackTime() {
        return recordBackTime;
    }

    public void setRecordBackTime(String recordBackTime) {
        this.recordBackTime = recordBackTime;
    }

    public int getBookType() {
        return bookType;
    }

    public void setBookType(int bookType) {
        this.bookType = bookType;
    }

    public int getRecordBookState() {
        return recordBookState;
    }

    public void setRecordBookState(int recordBookState) {
        this.recordBookState = recordBookState;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserIphone() {
        return userIphone;
    }

    public void setUserIphone(String userIphone) {
        this.userIphone = userIphone;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }
    public String getBookInsideCode() {return bookInsideCode;}

    public void setBookInsideCode(String bookInsideCode) {this.bookInsideCode = bookInsideCode;}

}