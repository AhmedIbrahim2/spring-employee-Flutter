package com.example.restfulapi.repository;


import com.example.restfulapi.model.user_auth;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface userauth_repo extends JpaRepository<user_auth,Long > {
    user_auth findByEmailAndPassword(String email , String password);
}
