package com.bills.pay.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bills.pay.dao.entity.ServiceConsumerEntity;

public interface ServiceConsumerRepository extends JpaRepository<ServiceConsumerEntity, Long> {

}
