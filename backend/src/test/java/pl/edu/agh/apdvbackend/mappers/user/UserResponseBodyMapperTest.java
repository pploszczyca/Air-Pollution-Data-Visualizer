package pl.edu.agh.apdvbackend.mappers.user;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.mappers.group.short_group.ShortGroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;
import pl.edu.agh.apdvbackend.models.database.Group;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.doReturn;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class UserResponseBodyMapperTest {

    @MockBean
    private ShortGroupMapper shortGroupMapper;

    @Autowired
    private UserResponseBodyMapper mapper;

    @Test
    public void ShouldMapToUserResponseBody() {
        // Given
        final var id = 34L;
        final var email = "email@test.com";
        final Set<Group> groups = Collections.emptySet();
        final List<ShortGroupResponseBody> shortGroups = Collections.emptyList();
        final var user = UserFakes.builder()
                .id(id)
                .email(email)
                .groups(groups)
                .build();
        final var expected = new UserResponseBody(id, email, shortGroups);

        doReturn(shortGroups).when(shortGroupMapper).toShortGroupList(groups.stream().toList());

        // When
        final var result = mapper.toUserResponseBody(user);

        // Then
        assertEquals(expected, result);
    }

    @Test
    public void ShouldMapToUserResponseBodyList() {
        // Given
        final var id = 34L;
        final var email = "email@test.com";
        final Set<Group> groups = Collections.emptySet();
        final List<ShortGroupResponseBody> shortGroups = Collections.emptyList();
        final var user = UserFakes.builder()
                .id(id)
                .email(email)
                .groups(groups)
                .build();
        final var expected = List.of(new UserResponseBody(id, email, shortGroups));

        doReturn(shortGroups).when(shortGroupMapper).toShortGroupList(groups.stream().toList());

        // When
        final var result = mapper.toUserResponseBodyList(List.of(user));

        // Then
        assertEquals(expected, result);
    }
}