package com.example.restfulapi.services.auth;


import com.example.restfulapi.model.user_auth;
import org.springframework.stereotype.Service;

@Service
public interface userauthe {

    public user_auth login(user_auth user_auth);

    public user_auth register (user_auth user_auth);


}
