package pl.edu.agh.apdvbackend.mappers.user;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class LogInRequestBodyMapperTest {

    @Autowired
    private LogInRequestBodyMapper mapper;

    @Test
    void ShouldMapToLogInRequestBody() {
        // Given
        final var email = "email";
        final var password = "password";
        final var userRequestBody = new UserRequestBody(email, password);
        final var expected = new LogInRequestBody(email, password);

        // When
        final var result = mapper.map(userRequestBody);

        // Then
        assertEquals(expected, result);
    }
}
