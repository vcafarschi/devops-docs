package com.bills.pay.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bills.pay.dao.entity.UserDataEntity;
import com.bills.pay.model.LoginForm;
import com.bills.pay.model.SignupForm;
import com.bills.pay.model.UserDetailsModel;
import com.bills.pay.service.BillService;
import com.bills.pay.service.UserService;

@CrossOrigin("*")
@RestController
@RequestMapping("/factura-md")

public class UserController {

    @Autowired
    UserService userService;

    @PostMapping(value = "/login")
    public ResponseEntity<Object> logIn(@RequestBody @Valid LoginForm model) {
        return userService.find(model).isPresent() ? ResponseEntity.ok().body(userService.find(model)): ResponseEntity.notFound().build();
    }

    @PostMapping(value = "/signUp")
    public ResponseEntity<Object> signUp(@RequestBody @Valid SignupForm model) {
        Optional<UserDataEntity> optionalUserDataEntity=userService.save(model);

        return optionalUserDataEntity.isPresent() ? ResponseEntity.ok().body(optionalUserDataEntity): ResponseEntity.notFound().build();
    }

    @PostMapping(value = "/update")
    public ResponseEntity<Object> update(@RequestBody @Valid SignupForm model) {
        userService.update(model);

        return ResponseEntity.ok().build();
    }

    @PostMapping(value="/forgot-password")
    public ResponseEntity<Object> forgotUserPassword(@RequestParam String email) {
        return userService.forgotPassword(email).isPresent() ? ResponseEntity.ok().build(): ResponseEntity.notFound().build();

    }

    @GetMapping(value = "/user")
    public ResponseEntity<UserDetailsModel> getUserDetails(@RequestParam String userName) {
        Optional<UserDetailsModel> userDetailsModel=userService.getUserDetails(userName);
        return userDetailsModel.map(detailsModel -> ResponseEntity.ok().body(detailsModel)).orElseGet(() -> ResponseEntity.notFound().build());
    }
}
