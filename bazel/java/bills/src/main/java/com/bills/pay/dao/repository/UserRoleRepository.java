package com.bills.pay.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bills.pay.dao.entity.UserRoleEntity;

public interface UserRoleRepository extends JpaRepository<UserRoleEntity, Long> {

}
