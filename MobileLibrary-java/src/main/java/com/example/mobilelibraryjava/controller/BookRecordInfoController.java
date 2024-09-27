package com.example.mobilelibraryjava.controller;

import com.example.mobilelibraryjava.ApiResponse.ApiResponse;
import com.example.mobilelibraryjava.Utils.RecordBookState;
import com.example.mobilelibraryjava.Utils.UserRole;
import com.example.mobilelibraryjava.Utils.Utils;
import com.example.mobilelibraryjava.Utils.ValidatorUtils;
import com.example.mobilelibraryjava.bean.BookRecordInfo;
import com.example.mobilelibraryjava.request.BookRecordInfoRequest;
import com.example.mobilelibraryjava.request.BookRequest;
import com.example.mobilelibraryjava.service.BookRecordInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BookRecordInfoController {


    private BookRecordInfoService bookRecordService;

    @Autowired
    public void setBookRecordService(BookRecordInfoService bookRecordService) {
        this.bookRecordService = bookRecordService;
    }


//
//
//    /**
//     * 获取有关当前用户借阅记录中有没有这本书的记录，有的话不能再次结余
//     * @return  当前借阅记录数组
//     */
//    @PostMapping("/app/getAllBookRecord")
//    @ResponseBody
//    public ApiResponse getAllBookRecord(BookRecordInfoRequest recordRequest) {
//
//      String userId  = recordRequest.getUserId();
//      String userRole = recordRequest.getUserRole();
//
//        if (Utils.isEmptyOrBlank(userId)){
//            return   new ApiResponse("请先登录", 300, "");
//        }
//
//        if (Utils.isEmptyOrBlank(userRole)){
//            return   new ApiResponse("参数不正确", 300, "");
//        }
//
//        if (ValidatorUtils.comparePasswords(userRole, UserRole.READER.getRoleName())) {
//            return new ApiResponse("没有权限", 300, "");
//        }
//
//
//       List<BookRecordInfo> records = bookRecordService.getAllBookRecord();
//        if (records.isEmpty()){
//            return new ApiResponse("获取借阅记录列表为空", 300, "");
//        }
//
//        return new ApiResponse("获取书籍列表成功", 200, records);
//    }


    /**
     *  搜索借阅记录
     *
     *
     */
    @PostMapping("/app/searchBookRecord")
    @ResponseBody
    public ApiResponse searchBookRecord(BookRecordInfoRequest recordRequest) {

        String userId  = recordRequest.getUserId();
        String userName  = recordRequest.getUserName();
        String userIphone = recordRequest.getUserIphone();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        List <BookRecordInfo> arr = bookRecordService.getAllSearchResult(userName,userIphone);


        if (Utils.isEmpty(arr)){
            return new ApiResponse("暂无数据", 300, "");
        }
        return new ApiResponse("搜索成功", 200, arr);
    }





    /**
     *  归还图书
     *
     * 用户操作归还之后，就从记录表中移除
     */
    @PostMapping("/app/backBook")
    @ResponseBody
    public ApiResponse backBook(BookRecordInfoRequest recordRequest) {

        String userId  = recordRequest.getUserId();
        int  recordId = recordRequest.getRecordId();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        BookRecordInfo recordInfo  = bookRecordService.borrowerBookInfoByRecordId(recordId);
        if (Utils.isNull(recordId)){
            return new ApiResponse("记录id不能为空", 300, "");
        }

        boolean state = bookRecordService.backBookRecordUpdateInfoById(userId,recordId);
        if (state){
            return new ApiResponse("已经归还", 200, "");
        }
        return new ApiResponse("归还失败", 300, "");
    }




    /**
     * 用户申请借阅之后，审核员审批通过之后需要调用这个接口进行更新借阅记录表中的状态
     *
     * 更新借阅的状态
     */
    @PostMapping("/app/updateBorrowBookRecordState")
    @ResponseBody
    public ApiResponse updateBorrowBookRecordState(BookRecordInfoRequest recordRequest) {

        String userId  = recordRequest.getUserId();
        int  recordId = recordRequest.getRecordId();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        BookRecordInfo recordInfo  = bookRecordService.borrowerBookInfoByRecordId(recordId);
        if (Utils.isNull(recordId)){
            return new ApiResponse("记录id不能为空", 300, "");
        }

        recordInfo.setRecordBookState(RecordBookState.BORROWED_SUCCESSFULLY.getValue());

        boolean state = bookRecordService.updateBookRecordInfoById(recordInfo);
        if (state){

            return new ApiResponse("借阅审核已通过", 200, "");
        }
        return new ApiResponse("借阅审核遇到了错误", 300, "");
    }


    /**
     *
     * 获取指定状态的借阅记录
     */
    @PostMapping("/app/allBookRecordStateInfo")
    @ResponseBody
    public ApiResponse allBookRecordStateInfo(BookRecordInfoRequest recordRequest) {

        String userId  = recordRequest.getUserId();
        int reacordBookState = recordRequest.getReacordBookState();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        List<BookRecordInfo> resultList = bookRecordService.getAllBorrowerInfoByRecordBookState(reacordBookState);
        if (resultList.isEmpty()){
            return new ApiResponse("获取申请借阅列表失败!", 300, "");
        }
        return new ApiResponse("获取申请借阅列表成功！", 200, resultList);
    }




        /**
         *
         * 当前图书是否已被当前用户所借阅
         */
    @PostMapping("/app/getBookRecordState")
    @ResponseBody
    public ApiResponse getBookRecordState(BookRecordInfoRequest recordRequest) {

        String userId  = recordRequest.getUserId();
        String recordBookISBN = recordRequest.getRecordBookISBN();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        if (Utils.isEmptyOrBlank(recordBookISBN)){
            return   new ApiResponse("参数不正确", 300, "");
        }

        int state = bookRecordService.getBookRecordInfoState(recordBookISBN,userId);
        Map<String, Object> res = new HashMap<>();
        if (state > 0){
            res.put("isHaveRecord", state);
            return new ApiResponse("获取书籍列表成功", 200, res);
        }
        res.put("isHaveRecord", 0);
        return new ApiResponse("获取书籍列表成功", 200, res);
    }





    /**
     *
     * 申请借阅
     */
    @PostMapping("/app/applyForBorrow")
    @ResponseBody
    public ApiResponse applyForBorrow(BookRecordInfoRequest recordRequest) {

        String userId  = recordRequest.getUserId();
        String bookTitle = recordRequest.getRecordBookTitle();
        String recordBookISBN = recordRequest.getRecordBookISBN();
        String bookAuthor = recordRequest.getRecordBookAuthor();
        String bookPress = recordRequest.getRecordBookPress();
        String iphone = recordRequest.getUserIphone();
        String userName = recordRequest.getRecordBorrower();
        int bookType = recordRequest.getBookType();
        //借阅时间
        String borrowerTime = recordRequest.getRecordBorrowerTime();
        //归还时间
        String backTime = recordRequest.getRecordBackTime();

        String updateTime = recordRequest.getUpdateTime();
        String bookInsideCode = recordRequest.getBookInsideCode();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        if (Utils.isEmptyOrBlank(userId) || Utils.isEmptyOrBlank(bookTitle)
                || Utils.isEmptyOrBlank(recordBookISBN) || Utils.isEmptyOrBlank(bookAuthor)
                || Utils.isEmptyOrBlank(bookPress) || Utils.isEmptyOrBlank(iphone)
                || Utils.isEmptyOrBlank(userName) || Utils.isEmptyOrBlank(borrowerTime)
                || Utils.isEmptyOrBlank(backTime) ||  Utils.isEmptyOrBlank(bookInsideCode)){

            return  new ApiResponse("参数错误", 300, "");
        }



        ///是否存在你
        int state = bookRecordService.getBookRecordInfoState(recordBookISBN,userId);
        if (state > 0){
            return  new ApiResponse("已经借阅过啦！不要重复申请", 300, "");
        }

            BookRecordInfo recordInfo = new BookRecordInfo();
            recordInfo.setUserId(userId);
            recordInfo.setRecordBookTitle(bookTitle);
            recordInfo.setRecordBookISBN(recordBookISBN);
            recordInfo.setRecordBookPress(bookPress);
            recordInfo.setUserIphone(iphone);
            recordInfo.setRecordBookAuthor(bookAuthor);
            recordInfo.setRecordBorrower(userName);
            recordInfo.setRecordBorrowerTime(borrowerTime);
            recordInfo.setRecordBackTime(backTime);
            recordInfo.setRecordBookState(1);
            recordInfo.setCreateTime(borrowerTime);
            recordInfo.setUpdateTime(updateTime);
            recordInfo.setBookType(bookType);
            recordInfo.setBookInsideCode(bookInsideCode);
            boolean resultState = bookRecordService.addBookRecord(recordInfo);

            if (resultState){
                return new ApiResponse("借阅申请成功,请等待管理员审核", 200, "");
            }
            return new ApiResponse("借阅申请失败", 300, "");
    }


    /**
     *
     * 更新借阅信息
     */
    @PostMapping("/app/updateBorrowInfo")
    @ResponseBody
    public ApiResponse updateBorrowInfo(BookRecordInfoRequest recordRequest) {

        String userId  = recordRequest.getUserId();
        String bookTitle = recordRequest.getRecordBookTitle();
        String recordBookISBN = recordRequest.getRecordBookISBN();
        String bookAuthor = recordRequest.getRecordBookAuthor();
        String bookPress = recordRequest.getRecordBookPress();
        String iphone = recordRequest.getUserIphone();
        String userName = recordRequest.getRecordBorrower();
        int bookType = recordRequest.getBookType();
        //借阅时间
        String borrowerTime = recordRequest.getRecordBorrowerTime();
        //归还时间
        String backTime = recordRequest.getRecordBackTime();

        String updateTime = recordRequest.getUpdateTime();
        int recordId = recordRequest.getRecordId();

        String bookInsideCode = recordRequest.getBookInsideCode();

        if (Utils.isEmptyOrBlank(userId)){
            return   new ApiResponse("请先登录", 300, "");
        }

        if (Utils.isEmptyOrBlank(userId) || Utils.isEmptyOrBlank(bookTitle)
                || Utils.isEmptyOrBlank(recordBookISBN) || Utils.isEmptyOrBlank(bookAuthor)
                || Utils.isEmptyOrBlank(bookPress) || Utils.isEmptyOrBlank(iphone)
                || Utils.isEmptyOrBlank(userName) || Utils.isEmptyOrBlank(borrowerTime)
                || Utils.isEmptyOrBlank(backTime) || Utils.isEmptyOrBlank(bookInsideCode) ){

            return  new ApiResponse("参数错误", 300, "");
        }



        ///是否存在你
        int state = bookRecordService.getBookRecordInfoState(recordBookISBN,userId);
        if (state <= 0){
            return  new ApiResponse("该条借阅数据不存在", 300, "");
        }

        BookRecordInfo recordInfo = new BookRecordInfo();
        recordInfo.setRecordId(recordId);
        recordInfo.setUserId(userId);
        recordInfo.setRecordBookTitle(bookTitle);
        recordInfo.setRecordBookISBN(recordBookISBN);
        recordInfo.setRecordBookPress(bookPress);
        recordInfo.setUserIphone(iphone);
        recordInfo.setRecordBookAuthor(bookAuthor);
        recordInfo.setRecordBorrower(userName);
        recordInfo.setRecordBorrowerTime(borrowerTime);
        recordInfo.setRecordBackTime(backTime);
        recordInfo.setRecordBookState(1);
        recordInfo.setCreateTime(borrowerTime);
        recordInfo.setUpdateTime(updateTime);
        recordInfo.setBookType(bookType);
        recordInfo.setBookInsideCode(bookInsideCode);
        boolean resultState = bookRecordService.updateBookRecordInfoById(recordInfo);

        if (resultState){
            return new ApiResponse("信息更新成功", 200, "");
        }
        return new ApiResponse("信息更新失败", 300, "");
    }


}
