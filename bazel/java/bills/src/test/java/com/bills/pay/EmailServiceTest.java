package com.bills.pay;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.bills.pay.service.EmailService;

public class EmailServiceTest {

    @Autowired
    EmailService emailService = new EmailService();

    @Test
    public void testEmail(){

        emailService.sendEmail("elena.grosu@ati.utm.md");
    }

}
