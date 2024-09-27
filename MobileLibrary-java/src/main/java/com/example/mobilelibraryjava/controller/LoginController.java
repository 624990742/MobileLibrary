package com.example.mobilelibraryjava.controller;

import com.example.mobilelibraryjava.bean.User;
import com.example.mobilelibraryjava.request.LoginRequest;
import com.example.mobilelibraryjava.service.LoginService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.sun.tools.attach.VirtualMachine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.example.mobilelibraryjava.Utils.Utils;
import com.example.mobilelibraryjava.Utils.ValidatorUtils;
import com.example.mobilelibraryjava.bean.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import com.example.mobilelibraryjava.ApiResponse.ApiResponse;
import java.util.HashMap;
import com.example.mobilelibraryjava.Utils.UserRole;
import com.example.mobilelibraryjava.Utils.ValidatorUtils;



@Controller
public class LoginController {
    private LoginService loginService;
    @Autowired
    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }
    @PostMapping("/app/login")
    @ResponseBody
    public ApiResponse loginCheck(LoginRequest loginRequest) {

         final ObjectMapper objectMapper = new ObjectMapper();
         int  loginType  = loginRequest.getLoginType();
         if (loginType < 1) {
             return  new  ApiResponse("登录方式错误", 300, "");
         }

        String pwd  = loginRequest.getPasswd();
         if (!ValidatorUtils.isValidPassword(pwd)){
             return  new ApiResponse("密码格式不正确", 400, "");
         }


         ApiResponse result = new ApiResponse("参数错误", 700, "");
         switch (loginType){
             case 1: ///手机号 + 密码
                 String iphone  = loginRequest.getIphone();
                 if (!Utils.isEmptyOrBlank(iphone)){

                     if (!ValidatorUtils.isValidChinaMobilePhoneNumber(iphone)){
                         return   new ApiResponse("手机号格式不正确", 250, "");
                     }

                     boolean isRegister = loginService.getMatchCountByIphone(iphone);
                     if (!isRegister){
                         return   new ApiResponse("请先注册", 250, "");
                     }

                     User user = loginService.getUserByIphone(iphone);
                     if (Utils.isNull(user)){
                         return   new ApiResponse("账号不存在", 250, "");
                     }


                     Boolean isLogin = ValidatorUtils.comparePasswords(pwd,user.userPassword);
                     if (!isLogin) {
                         return new ApiResponse("密码错误", 250, "");
                     }

                     try {
                         String jsonResponse = objectMapper.writeValueAsString(user);
                         result  = new ApiResponse("登录成功", 200, jsonResponse);
                     } catch (JsonProcessingException e) {
                         throw new RuntimeException(e);
                     }
                 }
                 break;
             case 2:///借阅证号+密码
                String readCard = loginRequest.getReadCardId();
                if (!Utils.isEmptyOrBlank(readCard)){

                    if (!ValidatorUtils.isValidLibraryCardNumber(readCard)){
                        return   new ApiResponse("借阅证号不正确", 300, "");
                    }

                    boolean isRegister = loginService.getMatchCountByReadCardId(readCard);
                    if (!isRegister){
                        return   new ApiResponse("请先注册", 250, "");
                    }

                    User user = loginService.getUserByReadCardId(readCard);
                    if (Utils.isNull(user)){
                        return   new ApiResponse("账号不存在", 250, "");
                    }

                    Boolean isLogin = ValidatorUtils.comparePasswords(pwd,user.userPassword);
                    if (!isLogin) {
                        return new ApiResponse("密码错误", 250, "");
                    }

                    try {
                        String jsonResponse = objectMapper.writeValueAsString(user);
                        result  = new ApiResponse("获取数据成功", 200, jsonResponse);
                    } catch (JsonProcessingException e) {
                        throw new RuntimeException(e);
                    }
                }
                 break;
             default:
                 System.out.println("未知错误");
         }
         return  result;
    }


    /**
     * 注册接口，正式开发的时候还需要去核验喜爱手机端的验证码，这里为了简便一些没弄
     * @param loginRequest
     * @return
     */
    @PostMapping("/app/register")
    @ResponseBody
    public ApiResponse registerCheck(LoginRequest loginRequest) {
        final ObjectMapper objectMapper = new ObjectMapper();
        int  loginType  = loginRequest.getLoginType();
         ApiResponse result = new ApiResponse("后台内部错误", 700, "");
         String pwd = loginRequest.getPasswd();
         String iphone  = loginRequest.getIphone();
         String readCardId = loginRequest.getReadCardId();

         if (Utils.isEmptyOrBlank(pwd) || Utils.isEmptyOrBlank(iphone) || Utils.isEmptyOrBlank(readCardId)){
             return   result;
         }

         User user = new User();
         user.setUserIphone(iphone);
         user.setUserPassword(pwd);
         user.setReadCardId(readCardId);
         boolean  state  = loginService.registerUser(user);
         if (state){
             result = new ApiResponse("更新成功", 200, "");
         }else{
             result = new ApiResponse("更新失败", 300, "");
        }
        return result;
    }





    /**
     * 修改密码接口
     * @param loginRequest
     * @return
     */
    @PostMapping("/app/updateUser")
    @ResponseBody
    public ApiResponse updatePassword(LoginRequest loginRequest) {

        String pwd = loginRequest.getPasswd();
        String iphone  = loginRequest.getIphone();
        String readCardId = loginRequest.getReadCardId();
        if (Utils.isEmptyOrBlank(pwd) || Utils.isEmptyOrBlank(iphone) || Utils.isEmptyOrBlank(readCardId)){
            return   new ApiResponse("输入的内容有误", 700, "");
        }

        int userId = loginService.getUserIdByIPhoneAndCard(iphone,readCardId);
        if (userId < 1 ){
            return new ApiResponse("账号不存在", 300, "");
        }

        User user = new User();
        user.setUserId(String.valueOf(userId));
        user.setUserIphone(iphone);
        user.setUserPassword(pwd);
        user.setReadCardId(readCardId);
        boolean  state  = loginService.updateUser(user);
        ApiResponse  result;
        if (state){
            result = new ApiResponse("更新成功", 200, "");
        }else{
            result = new ApiResponse("更新失败", 300, "");
        }
        return result;
    }





    /**
     * 注销接口
     * @param loginRequest
     * @return
     */
    @PostMapping("/app/logout")
    @ResponseBody
    public ApiResponse logout(LoginRequest loginRequest) {
        String iphone  = loginRequest.getIphone();
        String readCardId = loginRequest.getReadCardId();
        if (Utils.isEmptyOrBlank(iphone) || Utils.isEmptyOrBlank(readCardId)){
            return   new ApiResponse("输入的内容有误", 700, "");
        }

        int userId = loginService.getUserIdByIPhoneAndCard(iphone,readCardId);
        if (userId < 1 ){
            return new ApiResponse("账号不存在", 300, "");
        }
        ///userid  是表中唯一并且不可能重复的建所以每次操作它去获取数据
        User  user  = loginService.getUserByUserId(userId);

        if (ValidatorUtils.comparePasswords(user.userRole,UserRole.SUPER_ADMIN.getRoleName()) || ValidatorUtils.comparePasswords(user.userRole, UserRole.ADMIN.getRoleName())){
            return new ApiResponse("管理员不允许注销", 300, "");
        }

        boolean  state  = loginService.deleteUserById(userId);
        ApiResponse  result;
        if (state){
            result = new ApiResponse("注销成功", 200, "");
        }else{
            result = new ApiResponse("注销失败", 300, "");
        }
        return result;
    }





    /**
     * 更新用户个人信息
     * @param loginRequest
     * @return
     */
    @PostMapping("/app/updateUserInfo")
    @ResponseBody
    public ApiResponse updateUserInfo(LoginRequest loginRequest) {
        String iphone  = loginRequest.getIphone();
        String readCardId = loginRequest.getReadCardId();
        if (Utils.isEmptyOrBlank(iphone) || Utils.isEmptyOrBlank(readCardId)){
            return   new ApiResponse("输入的内容有误", 700, "");
        }

        int userId = loginService.getUserIdByIPhoneAndCard(iphone,readCardId);
        if (userId < 1 ){
            return new ApiResponse("账号不存在", 300, "");
        }
        ///userid  是表中唯一并且不可能重复的建所以每次操作它去获取数据
        User  user  = loginService.getUserByUserId(userId);

        if (ValidatorUtils.comparePasswords(user.userRole,UserRole.SUPER_ADMIN.getRoleName()) || ValidatorUtils.comparePasswords(user.userRole, UserRole.ADMIN.getRoleName())){
            return new ApiResponse("管理员不允许注销", 300, "");
        }

        boolean  state  = loginService.deleteUserById(userId);
        ApiResponse  result;
        if (state){
            result = new ApiResponse("注销成功", 200, "");
        }else{
            result = new ApiResponse("注销失败", 300, "");
        }
        return result;
    }






}

