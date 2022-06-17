package com.bills.pay.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bills.pay.dao.entity.UserActivityEntity;

public interface UserActivityRepository extends JpaRepository<UserActivityEntity, Long> {

}
