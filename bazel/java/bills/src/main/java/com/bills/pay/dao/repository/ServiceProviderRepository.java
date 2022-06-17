package com.bills.pay.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bills.pay.dao.entity.ServiceProviderEntity;

public interface ServiceProviderRepository extends JpaRepository<ServiceProviderEntity, Long> {

}
