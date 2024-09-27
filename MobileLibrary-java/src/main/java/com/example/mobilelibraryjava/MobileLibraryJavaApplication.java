package com.example.mobilelibraryjava;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.example.mobilelibraryjava.dao")
public class MobileLibraryJavaApplication {

    public static void main(String[] args) {
        SpringApplication.run(MobileLibraryJavaApplication.class, args);
    }

}
