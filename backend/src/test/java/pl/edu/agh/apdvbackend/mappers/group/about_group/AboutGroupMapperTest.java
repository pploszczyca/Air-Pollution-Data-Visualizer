package pl.edu.agh.apdvbackend.mappers.group.about_group;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import pl.edu.agh.apdvbackend.fakes.GroupFakes;
import pl.edu.agh.apdvbackend.fakes.body_models.endpoint.GroupEndpointResponseBodyFakes;
import pl.edu.agh.apdvbackend.fakes.body_models.user.ShortUserResponseBodyFakes;
import pl.edu.agh.apdvbackend.mappers.group_endpoint.GroupEndpointResponseBodyMapper;
import pl.edu.agh.apdvbackend.mappers.user.ShortUserResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class AboutGroupMapperTest {

    @MockBean
    private ShortUserResponseBodyMapper shortUserResponseBodyMapper;

    @MockBean
    private GroupEndpointResponseBodyMapper groupEndpointMapper;

    @Autowired
    private AboutGroupMapper mapper;

    @Test
    public void ShouldMapToAboutResponseBody() {
        // Given
        final var groupId = 3324L;
        final var groupName = "groupName";
        final var group = GroupFakes.builder()
                .id(groupId)
                .name(groupName)
                .build();
        final var shortUsers = List.of(ShortUserResponseBodyFakes.builder().build());
        final var groupEndpointResponseBodies =
                List.of(GroupEndpointResponseBodyFakes.builder().build());
        final var expectedResult =
                new AboutGroupResponseBody(groupId, groupName, shortUsers, groupEndpointResponseBodies);

        Mockito.doReturn(shortUsers)
                .when(shortUserResponseBodyMapper).toShortUserList(group.getUsersInGroup().stream().toList());
        Mockito.doReturn(groupEndpointResponseBodies)
                .when(groupEndpointMapper).toResponseBodyList(group.getGroupEndpoints().stream().toList());

        // When
        final var result = mapper.toAboutGroupResponseBody(group);

        // Then
        assertEquals(expectedResult, result);
    }
}
