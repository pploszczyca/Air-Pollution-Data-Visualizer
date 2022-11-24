package pl.edu.agh.apdvbackend.mappers.user;

import java.util.Collections;
import java.util.Set;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.models.body_models.auth.UserWithRoles;
import pl.edu.agh.apdvbackend.models.database.Role;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class UserWithRolesMapperTest {

    @Autowired
    private UserWithRolesMapper mapper;

    @Test
    public void ShouldMapToUserWithRoles() {
        // Given
        final var id = 34L;
        final var email = "email@com.pl";
        final Set<Role> roles = Collections.emptySet();
        final var user = UserFakes.builder()
                .id(id)
                .email(email)
                .roles(roles)
                .build();
        final var expected = new UserWithRoles(id, email, roles.stream().toList());

        // When
        final var result = mapper.toUserWithRoles(user);

        // Then
        assertEquals(expected, result);
    }
}
