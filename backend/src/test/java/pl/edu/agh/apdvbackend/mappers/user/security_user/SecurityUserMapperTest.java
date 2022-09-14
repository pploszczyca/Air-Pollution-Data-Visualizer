package pl.edu.agh.apdvbackend.mappers.user.security_user;

import java.util.Collection;
import java.util.Collections;
import java.util.Set;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.models.database.Role;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.doReturn;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class SecurityUserMapperTest {

    @MockBean
    private SimpleGrantedAuthorityMapper simpleGrantedAuthorityMapper;

    @Autowired
    private SecurityUserMapper mapper;

    @Test
    public void ShouldMapToSecurityUser() {
        // Given
        final var email = "email@test.com";
        final var password = "password";
        final Set<Role> roles = Collections.emptySet();
        final Collection<SimpleGrantedAuthority> simpleGrantedAuthorities = Collections.emptyList();
        final var user = UserFakes.builder()
                .email(email)
                .password(password)
                .roles(roles)
                .build();
        final var expected = new User(email, password, simpleGrantedAuthorities);

        doReturn(simpleGrantedAuthorities).when(simpleGrantedAuthorityMapper).map(user);

        // When
        final var result = mapper.map(user);

        // Then
        assertEquals(expected, result);
    }
}