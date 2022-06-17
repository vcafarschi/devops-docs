package com.bills.pay;

import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Java6Assertions.assertThat;
import org.junit.experimental.categories.Category;

import com.bills.pay.model.LoginForm;

@Category(ComponentTest.class)
public class LoginFormTest {

    private static Validator propertyValidator;

    @BeforeAll
    public static void setup() {
        propertyValidator = Validation.buildDefaultValidatorFactory().getValidator();
    }

    @Test
    public void whenBlankName_thenOneConstraintViolation() {
        LoginForm user = new LoginForm();
        user.setName("sss");
        user.setPassword("");

        Set<ConstraintViolation<LoginForm>> violations = propertyValidator.validate(user);

        assertThat(violations.size()).isEqualTo(1);
    }

}
