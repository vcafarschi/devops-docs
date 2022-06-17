package com.bills.pay.dao.entity;

import java.sql.Timestamp;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user_activity")
public class UserActivityEntity {

    private int userActivityId;

    private int userId;

    private int actionTypeId;

    private Timestamp date;

    @Id
    @Column(name = "user_activity_id")
    public int getUserActivityId() {
        return userActivityId;
    }

    public void setUserActivityId(final int userActivityId) {
        this.userActivityId = userActivityId;
    }

    @Column(name = "user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(final int userId) {
        this.userId = userId;
    }

    @Column(name = "action_type_id")
    public int getActionTypeId() {
        return actionTypeId;
    }

    public void setActionTypeId(final int actionTypeId) {
        this.actionTypeId = actionTypeId;
    }

    @Column(name = "date")
    public Timestamp getDate() {
        return date;
    }

    public void setDate(final Timestamp date) {
        this.date = date;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final UserActivityEntity that = (UserActivityEntity) o;
        return userActivityId == that.userActivityId &&
                userId == that.userId &&
                actionTypeId == that.actionTypeId &&
                Objects.equals(date, that.date);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userActivityId, userId, actionTypeId, date);
    }
}
