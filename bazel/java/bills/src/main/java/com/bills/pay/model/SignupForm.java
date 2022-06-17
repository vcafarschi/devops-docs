package com.bills.pay.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class SignupForm extends LoginForm {

    @JsonProperty("firstName")
    private String firstName;

    @JsonProperty("lastName")
    private String lastName;

    @JsonProperty("username")
    private String userName;

    @JsonProperty("address")
    private String address;

    // @NotBlank(message = "Name may not be null")
    // @Size(min = 4, max = 15, message = "User name should have from 4 to 15 characters ")
    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;
    // @NotBlank(message = "Name may not be null")
    // @Size(min = 4, max = 15, message = "User name should have from 4 to 15 characters ")
    @JsonProperty("confirmPassword")
    private String confirmPassword;

}
