package com.example.restfulapi.services.auth;

import com.example.restfulapi.model.user_auth;
import com.example.restfulapi.repository.userauth_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class userauth_imp implements userauthe {


    @Autowired
    userauth_repo repo ;

    @Override
    public user_auth login(user_auth user_auth) {
       user_auth olduser = repo.findByEmailAndPassword(user_auth.getEmail() , user_auth.getPassword());
         return olduser;
    }

    @Override
    public user_auth register(user_auth user_auth) {
        return repo.save(user_auth);
    }
}
