package pl.edu.agh.apdvbackend.mappers.user.security_user;

import java.util.Collection;
import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.models.database.Role;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class UserSimpleGrantedAuthorityMapperTest {

    @Autowired
    private UserSimpleGrantedAuthorityMapper mapper;

    @Test
    public void ShouldMapToSimpleGrantedAuthorityCollection() {
        // Given
        final var userRole = Role.USER;
        final var adminRole = Role.ADMIN;
        final var roles = Set.of(userRole, adminRole);
        final var user = UserFakes.builder()
                .roles(roles)
                .build();
        final Collection<SimpleGrantedAuthority> expected = List.of(
                new SimpleGrantedAuthority(adminRole.name()),
                new SimpleGrantedAuthority(userRole.name())
        );

        // When
        final var result = mapper.map(user);

        // Then
        assertEquals(expected, result);
    }
}
