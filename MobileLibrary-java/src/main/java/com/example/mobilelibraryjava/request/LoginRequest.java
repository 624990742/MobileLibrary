package com.example.mobilelibraryjava.request;

public class LoginRequest {

    ///手机号
    private String iphone;

    ///密码
    private String passwd;

    //登录类型：1 手机号+密码  2 借阅证号 + 密码
    private  int loginType;

    public String userId;
    public String userName;
    public int userSex;
    public String userAge;
    public String userEmail;
    public String userRole;
    public int userState;
    public String cardId;
    public String readCardId;
    public String userUnit;
    public int breakNumber;
    public int adminLevel;
    public int borrowMaxNumber;
    public String borrowStartDate;
    public int borrowDay;
    public int fineMoney;
    public String employeeId;
    public String userIcon;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getUserSex() {
        return userSex;
    }

    public void setUserSex(int userSex) {
        this.userSex = userSex;
    }

    public String getUserAge() {
        return userAge;
    }

    public void setUserAge(String userAge) {
        this.userAge = userAge;
    }


    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }


    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public int getUserState() {
        return userState;
    }

    public void setUserState(int userState) {
        this.userState = userState;
    }

    public String getCardId() {
        return cardId;
    }

    public void setCardId(String cardId) {
        this.cardId = cardId;
    }

    public String getReadCardId() {
        return readCardId;
    }

    public void setReadCardId(String readCardId) {
        this.readCardId = readCardId;
    }

    public String getUserUnit() {
        return userUnit;
    }

    public void setUserUnit(String userUnit) {
        this.userUnit = userUnit;
    }

    public int getBreakNumber() {
        return breakNumber;
    }

    public void setBreakNumber(int breakNumber) {
        this.breakNumber = breakNumber;
    }

    public int getAdminLevel() {
        return adminLevel;
    }

    public void setAdminLevel(int adminLevel) {
        this.adminLevel = adminLevel;
    }

    public int getBorrowMaxNumber() {
        return borrowMaxNumber;
    }

    public void setBorrowMaxNumber(int borrowMaxNumber) {
        this.borrowMaxNumber = borrowMaxNumber;
    }

    public String getBorrowStartDate() {
        return borrowStartDate;
    }

    public void setBorrowStartDate(String borrowStartDate) {
        this.borrowStartDate = borrowStartDate;
    }

    public int getBorrowDay() {
        return borrowDay;
    }

    public void setBorrowDay(int borrowDay) {
        this.borrowDay = borrowDay;
    }

    public int getFineMoney() {
        return fineMoney;
    }

    public void setFineMoney(int fineMoney) {
        this.fineMoney = fineMoney;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getUserIcon() {
        return userIcon;
    }

    public void setUserIcon(String userIcon) {
        this.userIcon = userIcon;
    }

    public String getIphone() {
        return iphone;
    }

    public void setIphone(String iphone) {
        this.iphone = iphone;
    }


    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public int getLoginType() {
        return loginType;
    }

    public void setLoginType(int loginType) {
        this.loginType = loginType;
    }
}
