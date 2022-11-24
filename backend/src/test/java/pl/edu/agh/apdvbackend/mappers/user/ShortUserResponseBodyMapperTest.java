package pl.edu.agh.apdvbackend.mappers.user;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class ShortUserResponseBodyMapperTest {

    @Autowired
    private ShortUserResponseBodyMapper mapper;

    @Test
    public void ShouldMapToShortUserResponseBody() {
        // Given
        final var id = 43L;
        final var email = "email@test.com";
        final var user = UserFakes.builder()
                .id(id)
                .email(email)
                .build();
        final var expected = new ShortUserResponseBody(id, email);

        // When
        final var result = mapper.toShortUser(user);

        // Then
        assertEquals(expected, result);
    }

    @Test
    public void ShouldMapToShortUserResponseBodyList() {
        // Given
        final var id = 43L;
        final var email = "email@test.com";
        final var user = UserFakes.builder()
                .id(id)
                .email(email)
                .build();
        final var expected = List.of(new ShortUserResponseBody(id, email));

        // When
        final var result = mapper.toShortUserList(List.of(user));

        // Then
        assertEquals(expected, result);
    }
}
