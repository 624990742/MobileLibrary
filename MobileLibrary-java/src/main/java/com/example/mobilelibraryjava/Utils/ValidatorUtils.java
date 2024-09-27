package com.example.mobilelibraryjava.Utils;

import java.util.regex.Pattern;

public class ValidatorUtils {

    private static final String CHINA_MOBILE_PHONE_REGEX = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[8,9]))\\d{8}$";

    /**
     * 正式开发的时候使用这个正则
     * 要求一个字符串满足以下条件：
     *   private static final String PASSWORD_REGEX = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,18}$";
     * 字符串长度在6到18个字符之间。
     * 至少包含一个大写字母和一个小写字母。
     * 至少包含一个数字。
     * 为了快速开发使用下边这个
     */
    private static final String PASSWORD_REGEX = "^(?=(?:.*\\d){1,})\\w{6,18}$";

    private static final String LIBRARY_CARD_REGEX = "^BL\\d{1,8}$";
    /**
     * 判断手机号码格式是否正确
     *
     * @param phoneNumber 待验证的手机号码
     * @return 如果格式正确，返回true；否则返回false
     */
    public static boolean isValidChinaMobilePhoneNumber(String phoneNumber) {
        Pattern pattern = Pattern.compile(CHINA_MOBILE_PHONE_REGEX);
        return pattern.matcher(phoneNumber).matches();
    }

    /**
     * 判断密码格式是否正确
     *
     * @param password 待验证的密码
     * @return 如果格式正确，返回true；否则返回false
     */
    public static boolean isValidPassword(String password) {
        Pattern pattern = Pattern.compile(PASSWORD_REGEX);
        return pattern.matcher(password).matches();
    }



    /**
     * 判断借阅证号码格式是否正确
     *
     * @param cardNumber 待验证的借阅证号码
     * @return 如果格式正确，返回true；否则返回false
     */
    public static boolean isValidLibraryCardNumber(String cardNumber) {
        Pattern pattern = Pattern.compile(LIBRARY_CARD_REGEX);
        return pattern.matcher(cardNumber).matches();
    }


    /**
     * 比较两次输入的密码是否相等。
     *
     * @param loginPassword 用户登录时输入的密码。
     * @param registeredPassword 用户注册时设置并已存储在系统中的密码。
     * @return 若两密码完全相同，返回 true；否则返回 false。
     */
    public static boolean comparePasswords(String loginPassword, String registeredPassword) {
        return loginPassword != null && loginPassword.equals(registeredPassword);
    }
}
