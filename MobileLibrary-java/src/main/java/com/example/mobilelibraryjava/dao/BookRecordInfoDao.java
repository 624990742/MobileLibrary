package com.example.mobilelibraryjava.dao;

import com.example.mobilelibraryjava.bean.BookRecordInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Repository;
import org.mybatis.spring.SqlSessionTemplate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BookRecordInfoDao {
    private final static String NAMESPACE = "com.example.mobilelibraryjava.dao.BookRecordInfoDao.";
    @Resource
    private SqlSessionTemplate sqlSessionTemplate;



    public List<BookRecordInfo> getAllBookRecord() {
        return sqlSessionTemplate.selectList(NAMESPACE + "getAllBookRecord");
    }

    public int getBookRecordInfoState(String recordBookISBN,String userId) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("recordBookISBN", recordBookISBN);
        paramMap.put("userId", userId);
        Integer result = sqlSessionTemplate.selectOne(NAMESPACE + "getBookRecordInfoState" ,paramMap);
        int  bookBorrowState = 0;
        if (result != null) {
            bookBorrowState = sqlSessionTemplate.selectOne(NAMESPACE + "getBookRecordBookBorrowState" ,paramMap);
        }
        return  bookBorrowState;///不存在标识未申请
    }


    ///获取指定状态的借阅记录
    public  List<BookRecordInfo>  getAllBorrowerInfoByRecordBookState(int recordBookState){
       return  sqlSessionTemplate.selectList(NAMESPACE + "getAllBorrowerInfoByRecordBookState" ,recordBookState);
    }

   ///添加借阅记录
    public  int addBookRecord(BookRecordInfo bookRecordInfo){

        return sqlSessionTemplate.insert(NAMESPACE + "addBookRecord" , bookRecordInfo);
    }


    //根据借阅记录获取当前借阅记录数据
    public BookRecordInfo borrowerBookInfoByRecordId(int recordId){

        return  sqlSessionTemplate.selectOne(NAMESPACE + "borrowerBookInfoByRecordId" , recordId);
    }

    //获取所有的搜索结果
    public List<BookRecordInfo> getAllSearchResultForIphone(String userIphone){
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userIphone", userIphone);
        paramMap.put("recordBookState", 1);
        return  sqlSessionTemplate.selectList(NAMESPACE + "getAllSearchResultForIphone" , paramMap);
    }
    public List<BookRecordInfo> getAllSearchResultForName(String userName){
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userName", userName);
        paramMap.put("recordBookState", 1);
        return  sqlSessionTemplate.selectList(NAMESPACE + "getAllSearchResultForName" , paramMap);
    }


    ///更新借阅记录
    public int updateBookRecordInfoById(BookRecordInfo bookRecordInfo){
        return sqlSessionTemplate.update(NAMESPACE + "updateBookRecordInfoById", bookRecordInfo);
    }
    public  Boolean backBookRecordUpdateInfoById(String userId,int recordId){
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("recordId", recordId);
        paramMap.put("userId", userId);
        return sqlSessionTemplate.delete(NAMESPACE + "backBookRecordUpdateInfoById" , paramMap) > 0;
    }


}
