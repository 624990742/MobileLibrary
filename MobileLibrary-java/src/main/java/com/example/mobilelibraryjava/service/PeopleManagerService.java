package com.example.mobilelibraryjava.service;

import com.example.mobilelibraryjava.bean.User;
import com.example.mobilelibraryjava.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PeopleManagerService {
    @Autowired
    private UserDao userDao;


    public List<User> getAllManagerList(){
        return  userDao.getAllManagerList();
    }

    public List<User> getAllReaderList(){
        return  userDao.getAllReaderList();
    }

   public  boolean deleteUserById(Integer userId){
        return  userDao.deleteUserById(userId) > 0;
   }


}
