package com.bills.pay.dao.entity;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "action_type")
public class ActionTypeEntity {

    private int actionTypeId;

    private String actionName;

    @Id
    @Column(name = "action_type_id")
    public int getActionTypeId() {
        return actionTypeId;
    }

    public void setActionTypeId(final int actionTypeId) {
        this.actionTypeId = actionTypeId;
    }

    @Column(name = "action_name")
    public String getActionName() {
        return actionName;
    }

    public void setActionName(final String actionName) {
        this.actionName = actionName;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final ActionTypeEntity that = (ActionTypeEntity) o;
        return actionTypeId == that.actionTypeId &&
                Objects.equals(actionName, that.actionName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(actionTypeId, actionName);
    }
}
