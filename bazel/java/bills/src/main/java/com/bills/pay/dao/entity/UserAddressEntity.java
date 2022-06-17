package com.bills.pay.dao.entity;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "user_address")
public class UserAddressEntity {

    private int userAddressId;

    private AddressEntity addressByAddressId;

    @Id
    @Column(name = "user_address_id")
    public int getUserAddressId() {
        return userAddressId;
    }

    public void setUserAddressId(final int userAddressId) {
        this.userAddressId = userAddressId;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final UserAddressEntity that = (UserAddressEntity) o;
        return userAddressId == that.userAddressId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(userAddressId);
    }

    @ManyToOne
    @JoinColumn(name = "address_id", referencedColumnName = "address_id", nullable = false)
    public AddressEntity getAddressByAddressId() {
        return addressByAddressId;
    }

    public void setAddressByAddressId(final AddressEntity addressByAddressId) {
        this.addressByAddressId = addressByAddressId;
    }
}
