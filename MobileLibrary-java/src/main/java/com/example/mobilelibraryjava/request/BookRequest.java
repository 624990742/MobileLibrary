package com.example.mobilelibraryjava.request;

public class BookRequest {

    public  int bookId;

    public String bookISBN;

    public  String bookTitle;

    public String  bookAuthor;

    public  String bookPress;

    public   String  bookCategory;

    public   int   bookType;

    public  String   bookInsideCode;

    public  int bookLibTotal;

    public double bookPrice;


    public  String  bookUploadTime;


    public  String bookCover;


    public  String bookBrief;


    public  int  bookState;


    public  int  bookTotalPage;


    public  int  bookBackTotal;




    public String userId;
    public String searchKeyWord;


    public int getBookBackTotal() {
        return bookBackTotal;
    }

    public void setBookBackTotal(int bookBackTotal) {
        this.bookBackTotal = bookBackTotal;
    }

    public String getBookISBN() {return bookISBN;}

    public String getSearchKeyWord() {return searchKeyWord;}

    public int getBookId() {return bookId;}

    public void setBookId(int bookId) {this.bookId = bookId;}


    public String getUserId() {return userId;}
    public void setUserId(String userId) {this.userId = userId;}

    public void setBookISBN(String bookISBN) {this.bookISBN = bookISBN;}

    public void setSearchKeyWord(String searchKeyWord) {this.searchKeyWord = searchKeyWord;}

    public String getBookTitle() {return bookTitle;}

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public String getBookPress() {
        return bookPress;
    }

    public void setBookPress(String bookPress) {
        this.bookPress = bookPress;
    }

    public String getBookCategory() {
        return bookCategory;
    }

    public void setBookCategory(String bookCategory) {
        this.bookCategory = bookCategory;
    }
    public int getBookType() {
        return bookType;
    }

    public void setBookType(int bookType) {
        this.bookType = bookType;
    }

    public String getBookInsideCode() {
        return bookInsideCode;
    }

    public void setBookInsideCode(String bookInsideCode) {
        this.bookInsideCode = bookInsideCode;
    }

    public int getBookLibTotal() {
        return bookLibTotal;
    }

    public void setBookLibTotal(int bookLibTotal) {
        this.bookLibTotal = bookLibTotal;
    }

    public double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(double bookPrice) {
        this.bookPrice = bookPrice;
    }


    public String getBookUploadTime() {
        return bookUploadTime;
    }

    public void setBookUploadTime(String bookUploadTime) {
        this.bookUploadTime = bookUploadTime;
    }


    public String getBookCover() {
        return bookCover;
    }

    public void setBookCover(String bookCover) {
        this.bookCover = bookCover;
    }


    public String getBookBrief() {
        return bookBrief;
    }

    public void setBookBrief(String bookBrief) {
        this.bookBrief = bookBrief;
    }


    public int getBookState() {
        return bookState;
    }

    public void setBookState(int bookState) {
        this.bookState = bookState;
    }


    public int getBookTotalPage() {
        return bookTotalPage;
    }
    public void setBookTotalPage(int bookTotalPage) {
        this.bookTotalPage = bookTotalPage;
    }
}
