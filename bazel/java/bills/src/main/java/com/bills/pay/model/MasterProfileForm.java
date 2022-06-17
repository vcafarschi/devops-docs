package com.bills.pay.model;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MasterProfileForm {

    @JsonProperty("name")
    private String name;

    @JsonProperty("activity")
    private String activity;

    @JsonProperty("date")
    private Date date;

    @JsonProperty("experience")
    private String experience;

    @JsonProperty("city")
    private String city;

    @JsonProperty("telephone")
    private String telephone;

    @JsonProperty("schedule")
    private String schedule;

}
