package com.example.mobilelibraryjava.Utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.ArrayList;
import java.util.regex.Pattern;

public class Utils {

    /**
     * 判断对象是否为空
     *
     * @param object 要判断的对象
     * @return 如果对象为null则返回true，否则返回false
     */
    public static boolean isNull(Object object) {
        return object == null;
    }

    /**
     * 判断字符串是否为空或空白
     *
     * @param str 要判断的字符串
     * @return 如果字符串为null、空字符串或只包含空白字符，则返回true，否则返回false
     */
    public static boolean isEmptyOrBlank(String str) {
        return str == null || str.trim().isEmpty();
    }

    /**
     * 判断集合是否为空
     *
     * @param collection 要判断的集合
     * @return 如果集合为null或没有元素，则返回true，否则返回false
     */
    public static boolean isEmpty(Collection<?> collection) {
        return collection == null || collection.isEmpty();
    }

    /**
     * 判断数组是否为空
     *
     * @param array 要判断的数组
     * @return 如果数组为null或长度为0，则返回true，否则返回false
     */
    public static boolean isEmpty(Object[] array) {
        return array == null || array.length == 0;
    }

    // 可以继续添加其他类型的空判断方法...


    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    /**
     * 获取当前日期，并将其格式化为 "yyyy-MM-dd" 格式的字符串。
     *
     * @return 当前日期的 "yyyy-MM-dd" 格式字符串
     */
    public static String getCurrentDateFormatted() {
        LocalDate now = LocalDate.now();
        return now.format(FORMATTER);
    }





}