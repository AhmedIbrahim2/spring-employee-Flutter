package com.example.restfulapi.services;


import com.example.restfulapi.model.userdata;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface userdatas {
    public List<userdata> getalluser();
    public userdata getuser(Long id);
    public userdata create_user(userdata userdata);
    public  void delete(Long id);
    public String edit(userdata userdata , Long id);
}
