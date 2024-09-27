package com.example.mobilelibraryjava.service;

import com.example.mobilelibraryjava.bean.BookRecordInfo;
import com.example.mobilelibraryjava.dao.BookRecordInfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class BookRecordInfoService {

    @Autowired
    private BookRecordInfoDao bookRecordInfoDao;
    

    public List<BookRecordInfo> getAllBookRecord(){

        return bookRecordInfoDao.getAllBookRecord();
    }


    public int getBookRecordInfoState(String recordBookISBN,String userId){
        return bookRecordInfoDao.getBookRecordInfoState(recordBookISBN,userId);
    }

    public  List<BookRecordInfo> getAllBorrowerInfoByRecordBookState(int recordBookState){

        return bookRecordInfoDao.getAllBorrowerInfoByRecordBookState(recordBookState);
    }


    public  boolean addBookRecord(BookRecordInfo bookRecordInfo){
        return bookRecordInfoDao.addBookRecord(bookRecordInfo) > 0;
    }

    public List<BookRecordInfo> getAllSearchResult(String userName,String userIphone){


        if (userIphone.isEmpty()){
            return bookRecordInfoDao.getAllSearchResultForName(userName);
        }

        return  bookRecordInfoDao.getAllSearchResultForIphone(userIphone);
    }

    public BookRecordInfo borrowerBookInfoByRecordId(int recordId){
        return  bookRecordInfoDao.borrowerBookInfoByRecordId(recordId);
    }

    public boolean updateBookRecordInfoById(BookRecordInfo bookRecordInfo){
        return bookRecordInfoDao.updateBookRecordInfoById(bookRecordInfo) > 0;
    }

//    归还书本
    public  boolean backBookRecordUpdateInfoById(String userId,int recordId){

        return bookRecordInfoDao.backBookRecordUpdateInfoById(userId,recordId);
    }

}
