package com.example.mobilelibraryjava.service;

import com.example.mobilelibraryjava.bean.BookInfo;
import com.example.mobilelibraryjava.dao.BookInfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class BookInfoService {

    @Autowired
    private BookInfoDao bookInfoDao;


    /**
     * 获取所有图书
     *
     * @return book书籍信息列表
     */
    public List<BookInfo> getAllBooks() {
        return bookInfoDao.getAllBooks();
    }

    /**
     * 通过isbn图书编码获取图书信息
     * @param isbn 图书isbn编码
     * @return book书籍信息列表
     */
    public BookInfo getBookInfoByISBN(String isbn) {
        return bookInfoDao.getBookInfoByISBN(isbn);
    }



    /**
     * 根据书名或作者名称（部分）使用全文索引进行高效模糊搜索图书
     * （前提：数据库已为相关字段建立全文索引）
     *
     * @param searchKeyword 用户输入的搜索关键词，用于匹配书名或作者名
     * @return 包含匹配书籍信息的列表
     */
    public List<BookInfo> searchBooksByTitleAndAuthorMatch(String searchKeyword) {

        return bookInfoDao.searchBooksByTitleAndAuthorMatch(searchKeyword);
    }

    /**
     * 根据书名或作者名称（部分）模糊搜索图书
     *
     * @param searchKeyword 用户输入的搜索关键词，用于匹配书名或作者名
     * @return 包含匹配书籍信息的列表
     */
    public List<BookInfo> searchBooksByTitleAndAuthorLike(String searchKeyword) {
        return  bookInfoDao.searchBooksByTitleAndAuthorLike(searchKeyword);
    }

    /**
     * 根据书名或作者名称（部分）使用全文索引进行高效模糊搜索图书
     * （前提：数据库已为相关字段建立全文索引）
     *
     * @param searchKeyword 用户输入的搜索关键词，用于匹配书名或作者名
     * @return 包含匹配书籍信息的列表
     */
    public List<BookInfo> getBooksByTitleOrAuthor(String searchKeyword){
        return bookInfoDao.getBooksByTitleOrAuthor(searchKeyword);
    }

    public  Boolean addBook(BookInfo book) {
        return bookInfoDao.addBook(book);
    }

    public  Boolean isBookAddState(String bookISBN) {
        return bookInfoDao.isBookAddState(bookISBN) > 0;
    }

}
