package com.bills.pay.dao.repository;

import java.util.Date;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.bills.pay.dao.entity.InvoiceEntity;
import com.bills.pay.dao.entity.UserDataEntity;

public interface InvoiceRepository extends JpaRepository<InvoiceEntity, Long> {

    @Query("SELECT i FROM InvoiceEntity i "
            + "WHERE i.dataEmitere > :dateFrom "
            + "AND i.dataEmitere < :dateTo "
            + "AND i.serviceProviderName = :serviceProvider "
            + "AND i.addressByAddressId = :address")
    Optional<InvoiceEntity> findBill(Date dateFrom, Date dateTo, String serviceProvider, String address);
}
