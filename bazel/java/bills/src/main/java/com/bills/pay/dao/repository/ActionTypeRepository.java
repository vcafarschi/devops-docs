package com.bills.pay.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bills.pay.dao.entity.ActionTypeEntity;

public interface ActionTypeRepository extends JpaRepository<ActionTypeEntity, Long> {

}
