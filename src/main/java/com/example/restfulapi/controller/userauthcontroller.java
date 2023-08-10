package com.example.restfulapi.controller;


import com.example.restfulapi.model.user_auth;
import com.example.restfulapi.services.auth.userauth_imp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class userauthcontroller {



    @Autowired
    userauth_imp service ;


    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody user_auth user_auth) {
        try {
            user_auth loggedInUser = service.login(user_auth);
            if (loggedInUser != null) {
                // Login successful
                return ResponseEntity.ok("Login successful"); // Return 200 status
            } else {
                // Login failed
                return ResponseEntity.status(401).body("Login failed"); // Return 401 status
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    @PostMapping("/register")
    public user_auth register (@RequestBody user_auth user_auth){
        try {
            return service.register(user_auth);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


}
