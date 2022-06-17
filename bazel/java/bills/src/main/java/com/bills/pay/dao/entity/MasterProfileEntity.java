package com.bills.pay.dao.entity;

import java.sql.Date;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "master_profile")
public class MasterProfileEntity {

    private int masterProfileId;

    private String name;

    private String activity;

    private Date date;

    private String experience;

    private String city;

    private String telephone;

    private String schedule;

    @Id
    @Column(name = "master_profile_id")
    public int getMasterProfileId() {
        return masterProfileId;
    }

    public void setMasterProfileId(final int masterProfileId) {
        this.masterProfileId = masterProfileId;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    @Column(name = "activity")
    public String getActivity() {
        return activity;
    }

    public void setActivity(final String activity) {
        this.activity = activity;
    }

    @Column(name = "date")
    public Date getDate() {
        return date;
    }

    public void setDate(final Date date) {
        this.date = date;
    }

    @Column(name = "experience")
    public String getExperience() {
        return experience;
    }

    public void setExperience(final String experience) {
        this.experience = experience;
    }

    @Column(name = "city")
    public String getCity() {
        return city;
    }

    public void setCity(final String city) {
        this.city = city;
    }

    @Column(name = "telephone")
    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(final String telephone) {
        this.telephone = telephone;
    }

    @Column(name = "schedule")
    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(final String schedule) {
        this.schedule = schedule;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final MasterProfileEntity that = (MasterProfileEntity) o;
        return masterProfileId == that.masterProfileId &&
                Objects.equals(name, that.name) &&
                Objects.equals(activity, that.activity) &&
                Objects.equals(date, that.date) &&
                Objects.equals(experience, that.experience) &&
                Objects.equals(city, that.city) &&
                Objects.equals(telephone, that.telephone) &&
                Objects.equals(schedule, that.schedule);
    }

    @Override
    public int hashCode() {
        return Objects.hash(masterProfileId, name, activity, date, experience, city, telephone, schedule);
    }
}
