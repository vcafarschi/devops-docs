package com.bills.pay.service;

import java.util.Optional;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.bills.pay.dao.entity.UserDataEntity;
import com.bills.pay.dao.repository.UserRepository;
import com.bills.pay.model.LoginForm;
import com.bills.pay.model.SignupForm;
import com.bills.pay.model.UserDetailsModel;

@Service
public class UserService {

    @Autowired
    UserRepository repository;

    @Autowired
    private JavaMailSender emailSender;

    public Optional<UserDataEntity> save(final SignupForm newSignupForm) {
        Random ran = new Random();
        int x = ran.nextInt(6) + 5;
        UserDataEntity userEntity = new UserDataEntity();
        userEntity.setFirstName(newSignupForm.getFirstName());
        userEntity.setLastName(newSignupForm.getLastName());
        userEntity.setUsername(newSignupForm.getUserName());
        userEntity.setEmail(newSignupForm.getEmail());
        userEntity.setPassword(newSignupForm.getPassword());
        userEntity.setAddress(newSignupForm.getAddress());
        userEntity.setStatus("ACTIVE");
        userEntity.setUserId(x);
        return Optional.of(repository.save(userEntity));
    }

    public void update(final SignupForm user) {
        repository.update(user.getUserName(),user.getEmail(),user.getFirstName(),user.getLastName(),user.getAddress());
    }

    public Optional<UserDataEntity> find(final LoginForm model) {
        return repository.findUser(model.getName(), model.getPassword());
    }

    public Optional<Object> forgotPassword(final String email) {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("facturaMDfactura@gmail.com");
        message.setTo(email);
        message.setSubject("TEST");
        Random rnd = new Random();
        int number = rnd.nextInt(999999)+100000;

        message.setText("Buna, ati solicitat resetarea parolei contului, codul dumneavoastră de verificare este: "+number);
        emailSender.send(message);

        return Optional.of(email);
    }

    public Optional<UserDetailsModel> getUserDetails(String userName) {
        UserDataEntity user = repository.findUserByUsername(userName);
        UserDetailsModel userDetailsModel = new UserDetailsModel();
        userDetailsModel.setUserName(user.getUsername());
        userDetailsModel.setFirstName(user.getFirstName());
        userDetailsModel.setLastName(user.getLastName());
        userDetailsModel.setEmail(user.getEmail());
        userDetailsModel.setAddress(user.getAddress());
        return Optional.of(userDetailsModel);
    }

    public String getEmailByAddress(String address) {
        UserDataEntity user = repository.findUserByAddress(address);
        return user.getEmail();
    }

    public String getAddressByUsername(String username) {
        UserDataEntity user = repository.findUserByUsername(username);
        return user.getAddress();
    }
}

