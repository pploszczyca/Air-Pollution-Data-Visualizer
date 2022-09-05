package pl.edu.agh.apdvbackend.use_cases.auth;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.models.body_models.auth.UserWithRoles;
import pl.edu.agh.apdvbackend.models.database.Role;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class RemoveRoleFromUserImplTest {

    @Autowired
    private RemoveRoleFromUser removeRoleFromUser;

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    void init() {
        userRepository.deleteAll();
    }

    @Test
    public void throwExceptionWhenRoleIsNotCorrect() {
        final var userId = 1L;
        final var roleName = "BadRoleName";
        final var expectedMessage =
                "No enum constant pl.edu.agh.apdvbackend.models.database.Role." +
                        roleName;

        final var resultException = assertThrows(IllegalArgumentException.class,
                () -> removeRoleFromUser.execute(userId, roleName));

        assertEquals(expectedMessage, resultException.getMessage());
    }

    @Test
    public void removeRoleFromUser() {
        final var roleName = "USER";
        final var role = Role.USER;
        final var email = "userEmail";
        final var roles = new HashSet<>(Collections.singleton(role));
        final var user = UserFakes.getUser();
        user.setEmail(email);
        user.setRoles(roles);
        final var userId = userRepository.save(user).getId();
        final var expectedResult =
                new UserWithRoles(userId, email, List.of());

        final var result = removeRoleFromUser.execute(userId, roleName);

        assertEquals(expectedResult, result);
    }
}
