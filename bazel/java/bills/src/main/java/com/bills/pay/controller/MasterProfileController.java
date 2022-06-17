package com.bills.pay.controller;

import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bills.pay.dao.entity.MasterProfileEntity;
import com.bills.pay.model.MasterProfileForm;
import com.bills.pay.service.MasterProfileService;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/factura-md")
public class MasterProfileController {

    @Autowired
    MasterProfileService masterProfileService;

    @PostMapping(value = "/registerMaster")
    public ResponseEntity<Object> signUp(@RequestBody @Valid MasterProfileForm model) {
        Optional<MasterProfileEntity> optionalUserDataEntity=masterProfileService.save(model);

        return optionalUserDataEntity.isPresent() ? ResponseEntity.ok().body(optionalUserDataEntity): ResponseEntity.notFound().build();
    }
}
