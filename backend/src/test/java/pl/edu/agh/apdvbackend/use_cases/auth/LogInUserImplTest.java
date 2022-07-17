package pl.edu.agh.apdvbackend.use_cases.auth;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.authentication.BadCredentialsException;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;
import pl.edu.agh.apdvbackend.repositories.UserRepository;
import pl.edu.agh.apdvbackend.use_cases.user.AddUser;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class LogInUserImplTest {

    @Autowired
    private LogInUser logInUser;

    @Autowired
    private AddUser addUser;

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    void init() {
        userRepository.deleteAll();
    }

    @Test
    public void throwExceptionWhenAuthenticationFailed() {
        final var email = "test@test.com";
        final var password = "1234";
        final var logInRequestBody = new LogInRequestBody(email, password);
        final var expectedMessage = "Bad credentials";

        final var exception = assertThrows(BadCredentialsException.class,
                () -> logInUser.execute(logInRequestBody));

        assertEquals(expectedMessage, exception.getMessage());
    }

    @Test
    public void generateSuccessfulJwtResponse() {
        final var name = "Karol";
        final var email = "test@test.com";
        final var password = "1234";
        final var logInRequestBody = new LogInRequestBody(email, password);
        final var addUserRequestBody =
                new AddUserRequestBody(name, email, password);
        addUser.execute(addUserRequestBody);

        final var result = logInUser.execute(logInRequestBody);

        assertNotNull(result);
        assertFalse(result.accessToken().isEmpty());
        assertFalse(result.refreshToken().isEmpty());
    }
}