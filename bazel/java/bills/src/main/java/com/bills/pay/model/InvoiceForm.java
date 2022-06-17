package com.bills.pay.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
public class InvoiceForm {

    @JsonProperty("iban")
    private String iban;

    @JsonProperty("codulFiscal")
    private String codulFiscal;

    @JsonProperty("dataEmitere")
    private Date dataEmitere;

    @JsonProperty("dataExpediere")
    private Date dataExpediere;

    @JsonProperty("dataLimitaPlata")
    private Date dataLimitaPlata;

    @JsonProperty("perioadaCalcul")
    private String perioadaCalcul;

    @JsonProperty("volumConsumat")
    private String volumConsumat;

    @JsonProperty("pret")
    private String pret;

    @JsonProperty("pretLunar")
    private String pretLunar;

    @JsonProperty("tva")
    private String tva;

    @JsonProperty("datorii")
    private String datorii;

    @JsonProperty("suma")
    private String suma;

    @JsonProperty("contPersonal")
    private String contPersonal;

    @JsonProperty("address")
    private String address;

    @JsonProperty("serviceProviderName")
    private String serviceProviderName;

}
