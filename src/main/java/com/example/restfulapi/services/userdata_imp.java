package com.example.restfulapi.services;


import com.example.restfulapi.repository.userdata_repo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.restfulapi.model.userdata ;

import java.util.List;

@Service
public class userdata_imp implements userdatas{

    @Autowired
    userdata_repo repo ;

    @Override
    public List<userdata> getalluser() {
       try {
            return repo.findAll();
       } catch (Exception e) {
           throw new RuntimeException(e);
       }
    }

    @Override
    public userdata getuser(Long id) {

        try{
            return repo.findById(id).get();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public userdata create_user(userdata userdata) {

        try{
            return repo.save(userdata);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(Long id ) {

        try {
            repo.deleteById(id);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public String edit(userdata userdata, Long id) {
        userdata userdata1 = repo.findById(id).get();
        BeanUtils.copyProperties(userdata , userdata1 , "id");
        repo.save(userdata1);
        return "Edit Successfully";
    }
}
