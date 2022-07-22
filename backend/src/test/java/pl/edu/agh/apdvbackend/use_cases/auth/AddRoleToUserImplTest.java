package pl.edu.agh.apdvbackend.use_cases.auth;

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


@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class AddRoleToUserImplTest {

    @Autowired
    private AddRoleToUser addRoleToUser;

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    void init() {
        userRepository.deleteAll();
    }

    @Test
    public void addNewRoleToUser() {
        final var roleName = "USER";
        final var role = Role.USER;
        final var userId = 1L;
        final var name = "userName";
        final var email = "userEmail";
        final var expectedResult = new UserWithRoles(userId, name, email, List.of(role));
        final var user = UserFakes.getUser();
        user.setId(userId);
        user.setName(name);
        user.setEmail(email);
        user.setRoles(new HashSet<>());
        userRepository.save(user);

        final var result = addRoleToUser.execute(userId, roleName);

        assertEquals(expectedResult, result);
    }
}