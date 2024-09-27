package com.example.mobilelibraryjava.controller;

import com.example.mobilelibraryjava.ApiResponse.ApiResponse;
import com.example.mobilelibraryjava.Utils.Utils;
import com.example.mobilelibraryjava.bean.BookInfo;
import com.example.mobilelibraryjava.request.BookRequest;
import com.example.mobilelibraryjava.service.BookInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;


@Controller
public class BookInfoController {

    private BookInfoService bookInfoService;
    @Autowired
    public void setBookService(BookInfoService bookInfoService) {
        this.bookInfoService = bookInfoService;
    }

    /**
     * 获取所有的书本信息
     * @return  list
     */
    @PostMapping("/app/allBooks")
    @ResponseBody
    public ApiResponse getAllBooks(BookRequest bookRequest) {
        String userId = bookRequest.getUserId();
        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }
        List<BookInfo> bookInfos = bookInfoService.getAllBooks();
        if (Utils.isEmpty(bookInfos)){
            return new ApiResponse("失败", 300, "");
        }
        return new ApiResponse("获取书籍列表成功", 200, bookInfos);
    }





    /**
     * 获取精选图书列表
     * @return  list
     */
    @PostMapping("/app/hotBookList")
    @ResponseBody
    public ApiResponse hotBookList(BookRequest bookRequest) {

        List<BookInfo> allBookInfos = bookInfoService.getAllBooks();
        if (Utils.isEmpty(allBookInfos) && allBookInfos.size() < 4){
            return new ApiResponse("失败", 300, "");
        }

        List<Integer> indices = new ArrayList<>(allBookInfos.size());
        for (int i = 0; i < allBookInfos.size(); i++) {
            indices.add(i);
        }

        // 使用Collections.shuffle()对索引列表进行随机排序
        Collections.shuffle(indices, new Random());

        // 从随机排序的索引列表中取前4个，确保不会重复
        List<BookInfo> randomFourBookInfos = new ArrayList<>(4);
        for (int i = 0; i < 4; i++) {
            randomFourBookInfos.add(allBookInfos.get(indices.get(i)));
        }
        return new ApiResponse("获取书籍列表成功", 200, randomFourBookInfos);
    }



    /**
     * 获取所有的书本信息
     *  bookISBN 图书编码
     * @return  当前图书
     */
    @PostMapping("/app/bookInfo")
    @ResponseBody
    public ApiResponse getBook(BookRequest bookRequest) {
        String userId = bookRequest.getUserId();
        String bookISBN = bookRequest.getBookISBN();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        if (Utils.isEmptyOrBlank(bookISBN)){
            return   new ApiResponse("图书ISBN不能为空", 300, "");
        }

        BookInfo bookInfo = bookInfoService.getBookInfoByISBN(bookISBN);
        if (Utils.isNull(bookInfo)){
            return new ApiResponse("图书不存在", 300, "");
        }
        return new ApiResponse("获取书籍列表成功", 200, bookInfo);
    }





    /**
     *  模糊搜索
     *  关键字
     * @return  当前图书
     */
    @PostMapping("/app/searchBook")
    @ResponseBody
    public ApiResponse searchBook(BookRequest bookRequest) {
        String userId = bookRequest.getUserId();
        String keyWord = bookRequest.getSearchKeyWord();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        if (Utils.isEmptyOrBlank(keyWord)){
            return   new ApiResponse("关键字不能为空", 300, "");
        }

        List<BookInfo> result = bookInfoService.searchBooksByTitleAndAuthorMatch(keyWord);
        if (Utils.isNull(result)){
            return new ApiResponse("图书不存在", 300, "");
        }
        return new ApiResponse("获取书籍列表成功", 200, result);
    }




    /**
     *  模糊搜索
     *  关键字
     * @return  当前图书
     */
    @PostMapping("/app/addBook")
    @ResponseBody
    public ApiResponse addBook(BookRequest bookRequest) {
        String userId = bookRequest.getUserId();
        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }


        String bookTitle = bookRequest.getBookTitle();
        String bookISBN  = bookRequest.getBookISBN();
        String bookAuthor = bookRequest.getBookAuthor();
        String bookPress = bookRequest.getBookPress();
        String bookCategory = bookRequest.getBookCategory();
        int   bookType =  bookRequest.getBookType();
        String  bookInsideCode = bookRequest.getBookInsideCode();
        int bookLibTotal = bookRequest.getBookLibTotal();
        double bookPrice = bookRequest.getBookPrice();
        String  bookUploadTime =  bookRequest.bookUploadTime;
        String bookCover = bookRequest.getBookCover();
        String bookBrief = bookRequest.getBookBrief();
        int  bookState  = 0;//初次都是0
        int  bookTotalPage = bookRequest.getBookTotalPage();
        int  bookBackTotal = bookRequest.getBookBackTotal();



        boolean  isHave = bookInfoService.isBookAddState(bookISBN);
        if (isHave){
            return new ApiResponse("图书已存在", 300, "");
        }


        if (Utils.isEmptyOrBlank(bookTitle) || Utils.isEmptyOrBlank(bookISBN) ||
                Utils.isEmptyOrBlank(bookAuthor) || Utils.isEmptyOrBlank(bookPress)||
                Utils.isEmptyOrBlank(bookCategory) ||   Utils.isEmptyOrBlank(bookBrief)||
                bookLibTotal == 0 || bookPrice == 0 || bookTotalPage == 0){

            return new ApiResponse("请检查输入的内容", 300, "");
        }


        BookInfo book = new BookInfo();
        book.setBookTitle(bookTitle);
        book.setBookISBN(bookISBN);
        book.setBookAuthor(bookAuthor);
        book.setBookPress(bookPress);
        book.setBookCategory(bookCategory);
        book.setBookType(bookType);
        book.setBookInsideCode(bookInsideCode);
        book.setBookLibTotal(bookLibTotal);
        book.setBookPrice(bookPrice);
        book.setBookUploadTime(bookUploadTime);
        book.setBookCover(bookCover);
        book.setBookBrief(bookBrief);
        book.setBookState(0);
        book.setBookTotalPage(bookTotalPage);
        book.setBookBackTotal(bookBackTotal);

        boolean isSuccess = bookInfoService.addBook(book);
        if (!isSuccess){
            return new ApiResponse("添加图书失败", 300, "");
        }
        return new ApiResponse("添加图书成功", 200, "");
    }





}