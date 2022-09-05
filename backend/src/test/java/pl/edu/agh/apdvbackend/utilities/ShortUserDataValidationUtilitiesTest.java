package pl.edu.agh.apdvbackend.utilities;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.exceptions.IncorrectEmailException;
import pl.edu.agh.apdvbackend.validators.UserDataValidationUtilities;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
class ShortUserDataValidationUtilitiesTest {

    @Autowired
    private UserDataValidationUtilities userDataValidationUtilities;

    @ParameterizedTest
    @ValueSource(strings = {
            "@test.pl",
            "test1@test..pl",
            "test@",
            "@test.com",
            "test@test-com"
    })
    void testNotCorrectEmail(String email) {
        assertThrows(IncorrectEmailException.class, () -> userDataValidationUtilities.validateEmail(email));
    }

    @ParameterizedTest
    @ValueSource(strings = {"test1-23_it.works@test.pl"})
    void testCorrectEmail(String email) {
        assertDoesNotThrow(() -> userDataValidationUtilities.validateEmail(email));
    }
}
