package com.bills.pay.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bills.pay.dao.repository.UserRepository;
import com.bills.pay.model.InvoiceForm;
import com.bills.pay.service.BillService;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/factura-md")
public class BillController {

    @Autowired
    BillService billService;

    @Autowired
    UserRepository repository;

    @GetMapping(value = "/bill")
    public ResponseEntity<Object> getBillInfo(@RequestParam String data, @RequestParam String serviceProvider, @RequestParam String userName) throws ParseException {
        Date date=new SimpleDateFormat("yyyy-MM-dd").parse(data);
        return billService.find(date, serviceProvider, userName).isPresent() ? ResponseEntity.ok().body(billService.find(date, serviceProvider, userName)):
                ResponseEntity.notFound().build();
    }

    @PostMapping(value = "/importBill")
    public ResponseEntity<Object> importBill(@RequestBody InvoiceForm invoice) throws ParseException {

        return billService.register(invoice).isPresent() ? ResponseEntity.ok().build():
                ResponseEntity.notFound().build();
    }

}
