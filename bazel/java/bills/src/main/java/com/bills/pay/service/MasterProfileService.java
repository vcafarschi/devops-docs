package com.bills.pay.service;

import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bills.pay.dao.entity.MasterProfileEntity;
import com.bills.pay.dao.entity.UserDataEntity;
import com.bills.pay.dao.repository.MasterProfileRepository;
import com.bills.pay.dao.repository.UserRepository;
import com.bills.pay.model.MasterProfileForm;
import com.bills.pay.model.SignupForm;

@Service
public class MasterProfileService {

    @Autowired
    MasterProfileRepository repository;

    public Optional<MasterProfileEntity> save(final MasterProfileForm model) {
        Random ran = new Random();
        int x = ran.nextInt(6) + 5;
        MasterProfileEntity masterProfileEntity = new MasterProfileEntity();
        masterProfileEntity.setName(model.getName());
        masterProfileEntity.setActivity(model.getActivity());
        masterProfileEntity.setDate(model.getDate());
        masterProfileEntity.setExperience(model.getExperience());
        masterProfileEntity.setCity(model.getCity());
        masterProfileEntity.setTelephone(model.getTelephone());
        masterProfileEntity.setSchedule(model.getSchedule());
        masterProfileEntity.setMasterProfileId(x);
        return Optional.of(repository.save(masterProfileEntity));
    }
}
