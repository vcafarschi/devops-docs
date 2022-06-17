package com.bills.pay.dao.entity;

import java.sql.Timestamp;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "service_provider")
public class ServiceProviderEntity {

    private int serviceProviderId;

    private String name;

    private Timestamp registredOn;

    @Id
    @Column(name = "service_provider_id")
    public int getServiceProviderId() {
        return serviceProviderId;
    }

    public void setServiceProviderId(final int serviceProviderId) {
        this.serviceProviderId = serviceProviderId;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
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
        final ServiceProviderEntity that = (ServiceProviderEntity) o;
        return serviceProviderId == that.serviceProviderId &&
                Objects.equals(name, that.name) &&
                Objects.equals(registredOn, that.registredOn);
    }

    @Override
    public int hashCode() {
        return Objects.hash(serviceProviderId, name, registredOn);
    }
}
