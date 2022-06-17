package com.bills.pay.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bills.pay.dao.entity.AddressEntity;

public interface AddressRepository extends JpaRepository<AddressEntity, Long> {

}
