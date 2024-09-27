package com.example.mobilelibraryjava.service;

import com.example.mobilelibraryjava.Utils.Utils;
import com.example.mobilelibraryjava.bean.User;
import com.example.mobilelibraryjava.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class LoginService {

    @Autowired
    private UserDao userDao;


    public int getUserIdByIPhoneAndCard(String iphone,String readId){
        return  userDao.getUserIdByIPhoneAndCard(iphone,readId);
    }


    /**
     * 检查手机号和密码是否匹配任何用户记录。
     *
     * @param iphone 手机号
     * @param userPassword 密码
     * @return 如果存在匹配记录，则返回 true，否则返回 false
     */

    //手机号+密码获取对象
    public User getUserByIphone(String ihone) {
        return userDao.getUserByIphone(ihone);
    }
    public Boolean getMatchCountByIphone(String iphone) {
        return userDao.getMatchCountByIphone(iphone) > 0;
    }




    /**
     * 检查借阅号和密码是否匹配任何用户记录。
     *
     * @param readCardId 手机号
     * @param userPassword 密码
     * @return 如果存在匹配记录，则返回 true，否则返回 false
     */
    public  boolean getMatchCountByReadCardId(String readCardId) {
     return userDao.getMatchCountByReadCardId(readCardId) > 0;
    }
    //借阅证号+密码获取对象
    public User getUserByReadCardId(String readCardId) {
        return userDao.getUserByReadCardId(readCardId);
    }

    public  User getUserByUserId(int userId){
        return userDao.getUserByUserId(userId);
    }





    /**
     * 注册新用户。
     * 说明：初次注册没有的都以null字符串或者0代替
     * 正式开发应该以这种方式获取UUID为userid
     * String userId = UUID.randomUUID().toString();
     * 这里为了方便就随便弄了一个数字代替
     * @param user 待注册的用户对象
     * @return 受影响的行数（通常为 1，表示插入成功）
     */
       public  boolean registerUser(User user){

//           String  nullString = "null";
           user.setUserAge("18");
           user.setUserSex(0);
           user.setUserName("可爱的读者");
//           user.setUserEmail(nullString);
           user.setUserRole("reader");//新注册的都默认为读者
           user.setUserState(1);//状态正常
//           user.setCardId(nullString);
//           user.setUserUnit(nullString);
           user.setBreakNumber(1);
           user.setAdminLevel(1);
           user.setBorrowMaxNumber(6);
           user.setBorrowStartDate(Utils.getCurrentDateFormatted());///注册日期
//           user.setBorrowStartDate(nullString);
           user.setFineMoney(0);
           user.setEmployeeId("0");
           user.setUserIcon("userIcon1");
           int result = userDao.registerUser(user);
        return result > 0;
       }

     /// 更新用户数据
      public  boolean updateUser(User user){
        int result = userDao.updateUser(user);
        return result > 0;
     }



    //删除指定userId的对象
    public boolean deleteUserById(Integer userId) {
        int rowsAffected = userDao.deleteUserById(userId);
        return rowsAffected > 0; // 如果影响的行数大于0，则认为删除成功
    }

}
