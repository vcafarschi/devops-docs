package com.bills.pay.dao.entity;

import java.sql.Timestamp;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "address")
public class AddressEntity {

    private int addressId;

    private String street;

    private String city;

    private String bloc;

    private String oficiuPostal;

    private Timestamp registredOn;

    @Id
    @Column(name = "address_id")
    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(final int addressId) {
        this.addressId = addressId;
    }

    @Column(name = "street")
    public String getStreet() {
        return street;
    }

    public void setStreet(final String street) {
        this.street = street;
    }

    @Column(name = "city")
    public String getCity() {
        return city;
    }

    public void setCity(final String city) {
        this.city = city;
    }

    @Column(name = "bloc")
    public String getBloc() {
        return bloc;
    }

    public void setBloc(final String bloc) {
        this.bloc = bloc;
    }

    @Column(name = "oficiu_postal")
    public String getOficiuPostal() {
        return oficiuPostal;
    }

    public void setOficiuPostal(final String oficiuPostal) {
        this.oficiuPostal = oficiuPostal;
    }

    @Column(name = "registred_on")
    public Timestamp getRegistredOn() {
        return registredOn;
    }

    public void setRegistredOn(final Timestamp registredOn) {
        this.registredOn = registredOn;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final AddressEntity that = (AddressEntity) o;
        return addressId == that.addressId &&
                Objects.equals(street, that.street) &&
                Objects.equals(city, that.city) &&
                Objects.equals(bloc, that.bloc) &&
                Objects.equals(oficiuPostal, that.oficiuPostal) &&
                Objects.equals(registredOn, that.registredOn);
    }

    @Override
    public int hashCode() {
        return Objects.hash(addressId, street, city, bloc, oficiuPostal, registredOn);
    }
}
