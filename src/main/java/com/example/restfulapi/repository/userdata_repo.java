package com.example.restfulapi.repository;

import com.example.restfulapi.model.userdata;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface  userdata_repo extends JpaRepository<userdata,Long> {
}
