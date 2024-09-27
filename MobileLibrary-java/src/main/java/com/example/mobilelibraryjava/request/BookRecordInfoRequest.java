package com.example.mobilelibraryjava.request;

public class BookRecordInfoRequest {
    private String userId;

    private String userRole;

    // 书名
    private String recordBookTitle;

    // ISBN
    private String recordBookISBN;


    private int recordId;


    private String recordBookAuthor;
    // 借阅人
    private String recordBorrower;

    // 借阅时间（假设存储为字符串格式的日期时间）
    private String recordBorrowerTime;

    // 归还时间（假设存储为字符串格式的日期时间）
    private String recordBackTime;

    // 图书类别
    private int bookType;

    //0 未申请，1 申请中， 2已借阅（借阅中）
    private int  reacordBookState;
    // 图书出版社
    private String recordBookPress;

    // 用户名
    private String userName;

    // 用户手机号
    private String userIphone;

    // 创建时间
    private String createTime;

    // 更新时间
    private String updateTime;

    private  String  bookInsideCode;


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

    public String getRecordBookAuthor() {return recordBookAuthor;}

    public void setRecordBookTitle(String recordBookTitle) {
        this.recordBookTitle = recordBookTitle;
    }

    public void setRecordBookAuthor(String recordBookAuthor) {this.recordBookAuthor = recordBookAuthor;}

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

    public int getReacordBookState() { return reacordBookState;}

    public void setReacordBookState(int reacordBookState) { this.reacordBookState = reacordBookState;}

    public void setBookType(int bookType) {
        this.bookType = bookType;
    }


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
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

    public String getUserId() {return userId;}
    public void setUserId(String userId) {this.userId = userId;}

    public String getUserRole() {return userRole;}

    public void setUserRole(String userRole) {this.userRole = userRole;}

    public String getRecordBookPress() {return recordBookPress;}

    public void setRecordBookPress(String recordBookPress) {this.recordBookPress = recordBookPress;}

    public String getBookInsideCode() {
        return bookInsideCode;
    }

    public void setBookInsideCode(String bookInsideCode) {
        this.bookInsideCode = bookInsideCode;
    }

}
