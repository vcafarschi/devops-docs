package com.bills.pay.dao.entity;

import java.util.Date;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "invoice")
public class InvoiceEntity {

    private int invoiceId;

    private String iban;

    private String codulFiscal;

    private Date dataEmitere;

    private Date dataExpediere;

    private Date dataLimitaPlata;

    private String perioadaCalcul;

    private String volumConsumat;

    private String pret;

    private String pretLunar;

    private String tva;

    private String datorii;

    private String suma;

    private String contPersonal;

    private String addressByAddressId;

    private String serviceProviderName;

    @Id
    @Column(name = "invoice_id")
    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(final int invoiceId) {
        this.invoiceId = invoiceId;
    }

    @Column(name = "iban")
    public String getIban() {
        return iban;
    }

    public void setIban(final String iban) {
        this.iban = iban;
    }

    @Column(name = "codul_fiscal")
    public String getCodulFiscal() {
        return codulFiscal;
    }

    public void setCodulFiscal(final String codulFiscal) {
        this.codulFiscal = codulFiscal;
    }

    @Column(name = "data_emitere")
    public Date getDataEmitere() {
        return dataEmitere;
    }

    public void setDataEmitere(final Date dataEmitere) {
        this.dataEmitere = dataEmitere;
    }

    @Column(name = "data_expediere")
    public Date getDataExpediere() {
        return dataExpediere;
    }

    public void setDataExpediere(final Date dataExpediere) {
        this.dataExpediere = dataExpediere;
    }

    @Column(name = "data_limita_plata")
    public Date getDataLimitaPlata() {
        return dataLimitaPlata;
    }

    public void setDataLimitaPlata(final Date dataLimitaPlata) {
        this.dataLimitaPlata = dataLimitaPlata;
    }

    @Column(name = "perioada_calcul")
    public String getPerioadaCalcul() {
        return perioadaCalcul;
    }

    public void setPerioadaCalcul(final String perioadaCalcul) {
        this.perioadaCalcul = perioadaCalcul;
    }

    @Column(name = "volum_consumat")
    public String getVolumConsumat() {
        return volumConsumat;
    }

    public void setVolumConsumat(final String volumConsumat) {
        this.volumConsumat = volumConsumat;
    }

    @Column(name = "pret")
    public String getPret() {
        return pret;
    }

    public void setPret(final String pret) {
        this.pret = pret;
    }

    @Column(name = "pret_lunar")
    public String getPretLunar() {
        return pretLunar;
    }

    public void setPretLunar(final String pretLunar) {
        this.pretLunar = pretLunar;
    }

    @Column(name = "tva")
    public String getTva() {
        return tva;
    }

    public void setTva(final String tva) {
        this.tva = tva;
    }

    @Column(name = "datorii")
    public String getDatorii() {
        return datorii;
    }

    public void setDatorii(final String datorii) {
        this.datorii = datorii;
    }

    @Column(name = "suma")
    public String getSuma() {
        return suma;
    }

    public void setSuma(final String suma) {
        this.suma = suma;
    }

    @Column(name = "cont_personal")
    public String getContPersonal() {
        return contPersonal;
    }

    public void setContPersonal(final String contPersonal) {
        this.contPersonal = contPersonal;
    }

    @Column(name = "service_provider_name")
    public String getServiceProviderName() {
        return serviceProviderName;
    }

    public void setServiceProviderName(final String serviceProviderName) {
        this.serviceProviderName = serviceProviderName;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final InvoiceEntity that = (InvoiceEntity) o;
        return invoiceId == that.invoiceId &&
                Objects.equals(iban, that.iban) &&
                Objects.equals(codulFiscal, that.codulFiscal) &&
                Objects.equals(dataEmitere, that.dataEmitere) &&
                Objects.equals(dataExpediere, that.dataExpediere) &&
                Objects.equals(dataLimitaPlata, that.dataLimitaPlata) &&
                Objects.equals(perioadaCalcul, that.perioadaCalcul) &&
                Objects.equals(volumConsumat, that.volumConsumat) &&
                Objects.equals(pret, that.pret) &&
                Objects.equals(pretLunar, that.pretLunar) &&
                Objects.equals(tva, that.tva) &&
                Objects.equals(datorii, that.datorii) &&
                Objects.equals(suma, that.suma) &&
                Objects.equals(contPersonal, that.contPersonal);
    }

    @Override
    public int hashCode() {
        return Objects
                .hash(invoiceId, iban, codulFiscal, dataEmitere, dataExpediere, dataLimitaPlata, perioadaCalcul, volumConsumat, pret, pretLunar, tva, datorii,
                        suma,
                        contPersonal);
    }

    @Column(name = "address")
    public String getAddressByAddressId() {
        return addressByAddressId;
    }

    public void setAddressByAddressId(final String addressByAddressId) {
        this.addressByAddressId = addressByAddressId;
    }

    // @ManyToOne
    // @JoinColumn(name = "service_provider_id", referencedColumnName = "service_provider_id", nullable = false)
    // public ServiceProviderEntity getServiceProviderById() {
    //     return serviceProviderById;
    // }
    //
    // public void setServiceProviderById(final ServiceProviderEntity serviceProviderById) {
    //     this.serviceProviderById = serviceProviderById;
    // }
}
