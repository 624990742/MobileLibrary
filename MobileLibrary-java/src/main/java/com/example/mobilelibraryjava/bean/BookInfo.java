package com.example.mobilelibraryjava.bean;

public class BookInfo {
    // 图书编码
    private int bookId;

    // 书本名称
    private String bookTitle;

    // 图书标准ISBN编号
    private String bookISBN;

    //图书馆内部条形码
    private  String bookInsideCode;

    // 图书出版社
    private String bookPress;

    // 图书作者
    private String bookAuthor;

    // 图书价格
    private double bookPrice;

    // 图书总页数（这里应该使用整数类型，而非字符串）
    private int bookTotalPage;

    // 图书上架时间（使用 Date 类型而非字符串更为合适）
    private String bookUploadTime; // 注意：这里使用了 Date 类型来存储时间

    // 图书状态（0：可借阅，1:已借出，2：归还中，3：已下架）
    private int bookState;

    // 图书简介（这里使用 String 类型而非整数类型，可能是个错误）
    private String bookBrief; // 注意：这里假设图书简介是文本，所以使用了 String 类型

    // 类别（例如：0:数理化、1：社会科学、2：历史）
    private int bookType;

    // 图书封面（通常是图片的URL或本地文件路径）
    private String bookCover;

    // 图书库存总数
    private int bookLibTotal;

    // 已经归还数目
    private int bookBackTotal;

    // 图书中文分类
    private String bookCategory;

    // Getters and Setters

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getBookISBN() {
        return bookISBN;
    }

    public void setBookISBN(String bookISBN) {
        this.bookISBN = bookISBN;
    }

    public String getBookInsideCode() {
        return bookInsideCode;
    }

    public void setBookInsideCode(String bookInsideCode) {
        this.bookInsideCode = bookInsideCode;
    }

    public String getBookPress() {
        return bookPress;
    }

    public void setBookPress(String bookPress) {
        this.bookPress = bookPress;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(double bookPrice) {
        this.bookPrice = bookPrice;
    }

    public int getBookTotalPage() {
        return bookTotalPage;
    }

    public void setBookTotalPage(int bookTotalPage) {
        this.bookTotalPage = bookTotalPage;
    }

    public String getBookUploadTime() {
        return bookUploadTime;
    }

    public void setBookUploadTime(String bookUploadTime) {
        this.bookUploadTime = bookUploadTime;
    }

    public int getBookState() {
        return bookState;
    }

    public void setBookState(int bookState) {
        this.bookState = bookState;
    }

    public String getBookBrief() {
        return bookBrief;
    }

    public void setBookBrief(String bookBrief) {
        this.bookBrief = bookBrief;
    }

    public int getBookType() {
        return bookType;
    }

    public void setBookType(int bookType) {
        this.bookType = bookType;
    }

    public String getBookCover() {
        return bookCover;
    }

    public void setBookCover(String bookCover) {
        this.bookCover = bookCover;
    }

    public int getBookLibTotal() {
        return bookLibTotal;
    }

    public void setBookLibTotal(int bookLibTotal) {
        this.bookLibTotal = bookLibTotal;
    }

    public int getBookBackTotal() {
        return bookBackTotal;
    }

    public void setBookBackTotal(int bookBackTotal) {
        this.bookBackTotal = bookBackTotal;
    }

    public String getBookCategory() {
        return bookCategory;
    }

    public void setBookCategory(String bookCategory) {
        this.bookCategory = bookCategory;
    }
}