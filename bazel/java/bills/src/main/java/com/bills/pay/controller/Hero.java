package com.bills.pay.controller;

public class Hero {

    int number;
    String name;

    public int getNumber() {
        return number;
    }
    public Hero() {
    }
    public Hero(final int number, final String name) {
        this.number = number;
        this.name = name;
    }

    public void setNumber(final int number) {
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }
}
