package com.bills.pay.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bills.pay.dao.entity.UserAddressEntity;

public interface UserAddressRepository extends JpaRepository<UserAddressEntity, Long> {

}
