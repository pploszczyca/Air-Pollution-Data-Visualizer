package pl.edu.agh.apdvbackend.utilities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class UserDataValidationUtilitiesTest {

    @Autowired
    private UserDataValidationUtilities userDataValidationUtilities;


    @ParameterizedTest
    @CsvSource({"Piotr2000,true",
            "Piotr P,true",
            "1Piotr,false",
            "piotr.12,false",
            "pp,false",
            "pp ,false"})
    void testUsername(String username, boolean expected) {
        assertEquals(expected,
                userDataValidationUtilities.validateName(username));
    }

    @ParameterizedTest
    @CsvSource({"test1-23_it.works@test.pl,true",
            "@test.pl,false",
            "test1@test..pl,false",
            "test@,false",
            "@test.com,false",
            "test@test-com,false"})
    void testEmail(String email, boolean expected) {
        assertEquals(expected,
                userDataValidationUtilities.validateEmail(email));
    }
}
