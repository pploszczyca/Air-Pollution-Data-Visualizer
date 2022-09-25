package pl.edu.agh.apdvbackend.mappers.user;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.crypto.password.PasswordEncoder;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.doReturn;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class UserMapperTest {

    @MockBean
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserMapper mapper;

    @Test
    void ShouldMapToUser() {
        // Given
        final var email = "email";
        final var password = "password";
        final var encodedPassword = "encodedPassword";
        final var userRequestBody = new UserRequestBody(email, password);
        final var expected = UserFakes.builder()
                .id(null)
                .email(email)
                .password(encodedPassword)
                .build();

        doReturn(encodedPassword).when(passwordEncoder).encode(password);

        // When
        final var result = mapper.toUser(userRequestBody);

        // Then
        assertEquals(expected, result);
    }

    @Test
    void ShouldUpdateUser() {
        // Given
        final var id = 12L;
        final var email = "email";
        final var password = "password";
        final var encodedPassword = "encodedPassword";
        final var userRequestBody = new UserRequestBody(email, password);
        final var userToUpdate = UserFakes.builder()
                .id(id)
                .build();
        final var expected = UserFakes.builder()
                .id(id)
                .email(email)
                .password(encodedPassword)
                .build();

        doReturn(encodedPassword).when(passwordEncoder).encode(password);

        // When
        mapper.updateUser(userRequestBody, userToUpdate);

        // Then
        assertEquals(expected, userToUpdate);
    }
}
