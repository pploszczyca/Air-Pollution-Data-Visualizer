package pl.edu.agh.apdvbackend.use_cases.user;

import java.util.List;
import java.util.Set;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.models.database.Role;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class FindSecurityUserByEmailImplTest {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FindSecurityUserByEmail findSecurityUserByEmail;

    @BeforeEach
    void init() {
        userRepository.deleteAll();
    }

    @Test
    public void whenCantFindUserShouldThrowException() {
        final var email = "user@email.com";
        final var expectedExceptionMessage = "User not found in the database";

        final var exception = assertThrows(UsernameNotFoundException.class,
                () -> findSecurityUserByEmail.execute(email));

        assertEquals(expectedExceptionMessage, exception.getMessage());
    }

    @Test
    public void whenFindUserShouldMapToDetailsUser() {
        final var email = "user@email.com";
        final var password = "secret password";
        final var roles = Set.of(Role.USER, Role.ADMIN);
        final var user = UserFakes.getUser();
        final var expectedGrantedAuthorities = List.of(
                new SimpleGrantedAuthority(Role.USER.name()),
                new SimpleGrantedAuthority(Role.ADMIN.name())
        );
        user.setEmail(email);
        user.setPassword(password);
        user.setRoles(roles);
        userRepository.save(user);

        final var result = findSecurityUserByEmail.execute(email);

        assertEquals(email, result.getUsername());
        assertEquals(password, result.getPassword());
        assertTrue(result.getAuthorities()
                .containsAll(expectedGrantedAuthorities));
    }
}
