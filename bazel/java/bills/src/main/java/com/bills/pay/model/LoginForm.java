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
public class LoginForm {

    // @NotBlank(message = "Name may not be null")
    // @Size(min = 4, max = 10, message = "User name should have from 4 to 15 characters ")
    @JsonProperty("username")
    private String name;

    // @NotBlank(message = "Name may not be null")
    // @Size(min = 4, max = 10, message = "User name should have from 4 to 15 characters ")
    @JsonProperty("password")
    private String password;
}
