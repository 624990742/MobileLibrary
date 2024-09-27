package com.example.mobilelibraryjava.dao;


import jakarta.annotation.Resource;
import org.springframework.stereotype.Repository;
import com.example.mobilelibraryjava.bean.BookInfo;
import org.mybatis.spring.SqlSessionTemplate;
import java.util.List;

@Repository
public class BookInfoDao {
    private final static String NAMESPACE = "com.example.mobilelibraryjava.dao.BookInfoDao.";
    @Resource
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 根据ISBN获取图书详细信息
     *
     * @param isbn 图书的ISBN号码
     * @return 匹配的图书对象，若无匹配则返回null
     */
    public BookInfo getBookInfoByISBN(String isbn) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getBookInfoByISBN", isbn);
    }


    /**
     * 获取所有图书信息
     *
     * @return 所有图书对象组成的列表
     */
    public List<BookInfo> getAllBooks() {
        return sqlSessionTemplate.selectList(NAMESPACE + "getAllBooks");
    }


    /**
     * 根据书名或作者名称（部分）模糊搜索图书
     *
     * @param searchKeyword 用户输入的搜索关键词，用于匹配书名或作者名
     * @return 包含匹配书籍信息的列表
     */
    public List<BookInfo> searchBooksByTitleAndAuthorLike(String searchKeyword) {
        return sqlSessionTemplate.selectList(NAMESPACE + "searchBooksByTitleAndAuthorLike", searchKeyword);
    }


    /**
     * 根据书名或作者名称（部分）使用全文索引进行高效模糊搜索图书
     * （前提：数据库已为相关字段建立全文索引）
     *
     * @param searchKeyword 用户输入的搜索关键词，用于匹配书名或作者名
     * @return 包含匹配书籍信息的列表
     */
    public List<BookInfo> searchBooksByTitleAndAuthorMatch(String searchKeyword) {
        return sqlSessionTemplate.selectList(NAMESPACE + "searchBooksByTitleAndAuthorMatch", searchKeyword);
    }

    /**
     * 根据书名或作者名称（部分）使用全文索引进行高效模糊搜索图书
     * （前提：数据库已为相关字段建立全文索引）
     *
     * @param searchKeyword 用户输入的搜索关键词，用于匹配书名或作者名
     * @return 包含匹配书籍信息的列表
     */
    public List<BookInfo> getBooksByTitleOrAuthor(String searchKeyword) {
        return sqlSessionTemplate.selectList(NAMESPACE + "getBooksByTitleOrAuthor", searchKeyword);
    }


    ///新增图书
    public  Boolean addBook(BookInfo  book){

        return sqlSessionTemplate.insert(NAMESPACE + "addBook",book) > 0;
    }

  public  int isBookAddState(String bookISBN){
      return sqlSessionTemplate.insert(NAMESPACE + "isBookAddState",bookISBN);
  }
}
