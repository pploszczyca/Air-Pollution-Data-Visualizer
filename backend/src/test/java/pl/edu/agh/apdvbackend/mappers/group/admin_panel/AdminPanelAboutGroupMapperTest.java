package pl.edu.agh.apdvbackend.mappers.group.admin_panel;

import java.util.Collections;
import java.util.List;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import pl.edu.agh.apdvbackend.fakes.EndpointFakes;
import pl.edu.agh.apdvbackend.fakes.GroupEndpointFakes;
import pl.edu.agh.apdvbackend.fakes.GroupFakes;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class AdminPanelAboutGroupMapperTest {

    @SpyBean
    private AdminPanelGroupEndpointMapper endpointMapper;

    @Autowired
    private AdminPanelGroupMapper mapper;

    @Test
    public void toResponseBody() {
        // Given
        final var endpointId = 1L;
        final var endpoint = EndpointFakes.getEndpoint();
        endpoint.setId(endpointId);

        final var endpoints = List.of(endpoint);
        final var groupEndpoint = GroupEndpointFakes.getGroupEndpoint();
        groupEndpoint.setEndpoint(endpoint);

        final var groupId = 123L;
        final var groupName = "groupName";
        final var group = GroupFakes.getGroup();
        group.setId(groupId);
        group.setName(groupName);
        group.setGroupEndpoints(List.of(groupEndpoint));

        final var adminEndpoint = new AdminPanelGroupResponseBody.Endpoint(
                endpointId,
                "label",
                123,
                Collections.emptyList(),
                false
        );
        Mockito.doReturn(adminEndpoint).when(endpointMapper)
                .toEndpoint(Mockito.any(), Mockito.any());

        final var expected = new AdminPanelGroupResponseBody(
                groupId,
                groupName,
                List.of(adminEndpoint)
        );

        // When
        final var result = mapper.toResponseBody(group, endpoints);

        // Then
        assertEquals(expected, result);
    }

    @Nested
    class GetEndpointTest {
        @Test
        public void shouldMapToResponseBody_whenGroupHasEndpoint() {
            // Given
            final var endpoint = EndpointFakes.getEndpoint();
            endpoint.setId(1L);
            final var endpoints = List.of(endpoint);
            final var groupEndpoint = GroupEndpointFakes.getGroupEndpoint();
            groupEndpoint.setEndpoint(endpoint);
            final var group = GroupFakes.getGroup();
            group.setGroupEndpoints(List.of(groupEndpoint));

            // When
            mapper.getEndpoints(group, endpoints);

            // Then
            Mockito.verify(endpointMapper).toEndpoint(endpoint, groupEndpoint);
        }

        @Test
        public void shouldMapToResponseBody_whenGroupDoesntHaveEndpoint() {
            // Given
            final var endpoint = EndpointFakes.getEndpoint();
            endpoint.setId(1L);
            final var endpoints = List.of(endpoint);
            final var groupEndpoint = GroupEndpointFakes.getGroupEndpoint();
            final var group = GroupFakes.getGroup();
            group.setGroupEndpoints(List.of(groupEndpoint));

            // When
            mapper.getEndpoints(group, endpoints);

            // Then
            Mockito.verify(endpointMapper).toEndpoint(endpoint, null);
        }
    }
}
