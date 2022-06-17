package com.bills.pay.dao.entity;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user_role")
public class UserRoleEntity {

    private int userRoleId;

    private String roleName;

    @Id
    @Column(name = "user_role_id")
    public int getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(final int userRoleId) {
        this.userRoleId = userRoleId;
    }

    @Column(name = "role_name")
    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(final String roleName) {
        this.roleName = roleName;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final UserRoleEntity that = (UserRoleEntity) o;
        return userRoleId == that.userRoleId &&
                Objects.equals(roleName, that.roleName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userRoleId, roleName);
    }
}
