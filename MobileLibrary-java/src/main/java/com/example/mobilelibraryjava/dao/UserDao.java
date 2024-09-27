
package com.example.mobilelibraryjava.dao;
import com.example.mobilelibraryjava.bean.User;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import jakarta.annotation.Resource;

import java.nio.file.attribute.UserPrincipalLookupService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDao  {

    private final static String NAMESPACE = "com.example.mobilelibraryjava.dao.UserDao.";
    @Resource
    private SqlSessionTemplate sqlSessionTemplate;


   ///查找手机号有没有注册
    public int getMatchCountByIphone(String iphone) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getMatchCountByIphone", iphone);
    }

    ///借阅证有没有有没有注册
    public int getMatchCountByReadCardId(String readCard) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getMatchCountByReadCardId", readCard);
    }

    /// 根据手机号 + 密码 查询用户存在不存在
//    public int getMatchCountByIphoneAndPassword(String iphone, String password) {
//        Map<String, Object> paramMap = new HashMap<>();
//        paramMap.put("userIphone", iphone);
//        paramMap.put("userPassword", password);
//        return sqlSessionTemplate.selectOne(NAMESPACE + "getMatchCountByIphoneAndPassword", paramMap);
//    }

    /// 根据手机号和密码获取该对象的数据
    public User getUserByIphone(String phone) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getUserByIphone", phone);
    }

    /// 借阅证号 + 密码 查询用户存在不存在
    public User getUserByReadCardId(String readCardId) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getUserByReadCard", readCardId);
    }

    public  User getUserByUserId(int id){

        return sqlSessionTemplate.selectOne(NAMESPACE + "getUserByUserId", id);
    }





    public int getUserIdByIPhoneAndCard(String userIphone,String readCardId){
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userIphone", userIphone);
        paramMap.put("readCardId", readCardId);
        return sqlSessionTemplate.selectOne(NAMESPACE + "getUserIdByIPhoneAndCard", paramMap);
    }



    /**
     * 注册新用户。
     *
     * @param user 待注册的用户对象
     * @return 受影响的行数（通常为 1，表示插入成功）
     */
    public  int registerUser(User user) {
        return sqlSessionTemplate.insert(NAMESPACE+"registerUser",user);
    }

    /**
     * 更新用户
     *
     * @param user 用户对象更时候有值的字段会更新没值的不会更新
     * @return 受影响的行数（通常为 1，表示插入成功）
     */
    public int updateUser(User user) {
        return sqlSessionTemplate.update(NAMESPACE+"updateUser",user);
    }





    /**
     * 删除用户
     *
     * @param user 待注册的用户对象
     * @return 受影响的行数（通常为 1，表示插入成功）
     */
    public int deleteUserById(Integer userId) {
        return sqlSessionTemplate.delete(NAMESPACE + "deleteUserByUserId",userId);
    }



    /**
     * 获取所有管理员的数据列表
     *
     * @param user 管理员数据
     * @return   List<User>   管理员数据列表
     */
    public List<User> getAllManagerList(){
        return sqlSessionTemplate.selectList(NAMESPACE + "getAllManagerList");
    }


    /**
     * 获取所有读者的数据列表
     *
     * @param user 读者数据
     * @return   List<User>   读者数据列表
     */
    public List<User> getAllReaderList(){
        return sqlSessionTemplate.selectList(NAMESPACE + "getAllReaderList");
    }




}





/*
测试直接使用java注释的方式处理
package com.example.mobilelibraryjava.dao;
import org.apache.ibatis.annotations.*;
import com.example.mobilelibraryjava.bean.User;
@Mapper
public interface UserDao  {
//    @Select("SELECT * FROM userInfo WHERE userId = #{userId}")
//    @ResultMap("UserResultMap")
//    User getUserById(int userId);
    @Select("SELECT * FROM userInfo WHERE userIphone = #{userIphone}")
    @ResultMap("UserResultMap")
   User getUserByIphone(String userIphone);
//    @Select("SELECT * FROM userInfo WHERE readCardId = #{readCardId}")
//    @ResultMap("UserResultMap")
//    User getUserByReadCardId(int readCardId);


    @Select("SELECT 1")
    @Results(id = "UserResultMap",value = {
            @Result(property = "userId", column = "userId"),
            @Result(property = "userName", column = "userName"),
            @Result(property = "userSex", column = "userSex"),
            @Result(property = "userAge", column = "userAge"),
            @Result(property = "userIphone", column = "userIphone"),
            @Result(property = "userEmail", column = "userEmail"),
            @Result(property = "userPassword", column = "userPassword"),
            @Result(property = "userRole", column = "userRole"),
            @Result(property = "userState", column = "userState"),
            @Result(property = "cardId", column = "cardId"),
            @Result(property = "readCardId", column = "readCardId"),
            @Result(property = "userUnit", column = "userUnit"),
            @Result(property = "breakNumber", column = "breakNumber"),
            @Result(property = "adminLevel", column = "adminLevel"),
            @Result(property = "borrowMaxNumber", column = "borrowMaxNumber"),
            @Result(property = "borrowStartDate", column = "borrowStartDate"),
            @Result(property = "borrowDay", column = "borrowDay"),
            @Result(property = "fineMoney", column = "fineMoney"),
            @Result(property = "employeeId", column = "employeeId"),
            @Result(property = "userIcon", column = "userIcon")
    })
    User defineUserResultMap();
}*/
