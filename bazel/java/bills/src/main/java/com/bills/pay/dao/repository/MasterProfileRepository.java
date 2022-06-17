package com.bills.pay.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.bills.pay.dao.entity.MasterProfileEntity;

@Repository
public interface MasterProfileRepository extends JpaRepository<MasterProfileEntity, Long> {

}
