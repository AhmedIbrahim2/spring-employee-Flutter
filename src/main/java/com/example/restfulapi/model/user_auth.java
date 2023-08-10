package com.example.restfulapi.model;


import jakarta.persistence.*;

@Entity
public class user_auth {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "user_auth_id", nullable = false)
    private Long id;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private String email ;
    private String password ;



    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
