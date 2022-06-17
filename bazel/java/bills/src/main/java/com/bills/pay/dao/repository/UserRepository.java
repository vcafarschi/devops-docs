package com.bills.pay.dao.repository;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bills.pay.dao.entity.UserDataEntity;
import com.bills.pay.model.SignupForm;

@Repository
public interface UserRepository extends JpaRepository<UserDataEntity, Long> {

    @Modifying
    @Transactional
    @Query("UPDATE UserDataEntity u SET "
            + "u.address= :address, "
            + "u.email= :email, "
            + "u.firstName= :firstName,"
            + "u.lastName= :lastName "
            + "WHERE u.username = :userName")
    void update(@Param("userName") final String userName,
            @Param("email") final String email,
            @Param("firstName") final String firstName,
            @Param("lastName") final String lastName,
            @Param("address") final String address);

    @Query("SELECT u FROM UserDataEntity u "
            + "WHERE u.username = :username "
            + "AND u.password = :password "
            + "AND u.status = 'ACTIVE'")
    Optional<UserDataEntity> findUser(String username, String password);

    @Query("SELECT u FROM UserDataEntity u "
            + "WHERE u.username = :username ")
    UserDataEntity findUserByUsername(String username);

    @Query("SELECT u FROM UserDataEntity u "
            + "WHERE u.address = :address ")
    UserDataEntity findUserByAddress(String address);

    @Modifying
    @Transactional
    @Query("UPDATE UserDataEntity u SET "
            + "u.status= 'INACTIV' "
            + "WHERE u.username = :userName")
    void deactivate(@Param("userName") final String username);
}

