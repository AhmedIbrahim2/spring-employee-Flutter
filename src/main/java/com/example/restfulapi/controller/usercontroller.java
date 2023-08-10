package com.example.restfulapi.controller;


import com.example.restfulapi.model.userdata;
import com.example.restfulapi.services.userdata_imp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class usercontroller {

    @Autowired
    userdata_imp service ;


    @GetMapping("/getusers")
        public List<userdata> getallusers(){
        return service.getalluser();
      }



      @GetMapping("getuser/{id}")
    public userdata getuserbyid (@PathVariable Long id ){
        return service.getuser(id);
      }

   @PostMapping("createuser")
    public userdata create_user (@RequestBody userdata userdata){
        return service.create_user(userdata);
   }

   @DeleteMapping("deleteuser/{id}")
    public String deleteuser(@PathVariable Long id ){
        service.delete(id);
        return "deleted successfully";
   }

   @PutMapping("edituser/{id}")
        public String edituser(@PathVariable Long id , @RequestBody userdata userdata){
    return service.edit(userdata , id);
       }
}
