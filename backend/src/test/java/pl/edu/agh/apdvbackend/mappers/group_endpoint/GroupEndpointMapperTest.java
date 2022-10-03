package pl.edu.agh.apdvbackend.mappers.group_endpoint;

import java.util.Collections;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import pl.edu.agh.apdvbackend.fakes.EndpointFakes;
import pl.edu.agh.apdvbackend.fakes.GroupEndpointFakes;
import pl.edu.agh.apdvbackend.fakes.GroupEndpointKeyFakes;
import pl.edu.agh.apdvbackend.fakes.GroupFakes;
import pl.edu.agh.apdvbackend.mappers.field.IdsToFieldsMapper;
import pl.edu.agh.apdvbackend.mappers.group_endpoint_key.GroupEndpointKeyMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetEndpoint;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.doReturn;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class GroupEndpointMapperTest {

    @MockBean
    private GetEndpoint getEndpoint;

    @MockBean
    private IdsToFieldsMapper idsToFieldsMapper;

    @MockBean
    private GroupEndpointKeyMapper groupEndpointKeyMapper;

    @Autowired
    private GroupEndpointMapper mapper;

    @Test
    void ShouldMapToGroupEndpointList() {
        // Given
        final var endpointId = 53L;
        final var groupId = 34L;
        final List<Long> fieldIds = Collections.emptyList();
        final var endpoint = EndpointFakes.builder()
                .id(endpointId)
                .build();
        final var group = GroupFakes.builder()
                .id(groupId)
                .build();
        final var groupEndpointKey = GroupEndpointKeyFakes.builder()
                .endpointId(endpointId)
                .groupId(groupId)
                .build();
        final List<Field> fields = Collections.emptyList();
        final var requestBody =
                new GroupEndpointRequestBody(endpointId, fieldIds);
        final var expected = GroupEndpointFakes.builder()
                .id(groupEndpointKey)
                .group(group)
                .endpoint(endpoint)
                .enableFields(fields)
                .build();

        doReturn(endpoint).when(getEndpoint).execute(endpointId);
        doReturn(fields).when(idsToFieldsMapper).toFields(fieldIds);
        doReturn(groupEndpointKey).when(groupEndpointKeyMapper).map(groupId, endpointId);

        // When
        final var result = mapper.toEndpointGroup(requestBody, group);

        // Then
        assertThat(result).usingRecursiveComparison().isEqualTo(expected);
    }

    @Test
    void ShouldMapToEndpointGroup() {
        // Given
        final var endpointId = 53L;
        final var groupId = 34L;
        final List<Long> fieldIds = Collections.emptyList();
        final var endpoint = EndpointFakes.builder()
                .id(endpointId)
                .build();
        final var group = GroupFakes.builder()
                .id(groupId)
                .build();
        final var groupEndpointKey = GroupEndpointKeyFakes.builder()
                .endpointId(endpointId)
                .groupId(groupId)
                .build();
        final List<Field> fields = Collections.emptyList();
        final var requestBodies = List.of(
                new GroupEndpointRequestBody(endpointId, fieldIds)
        );
        final var expected = List.of(
                GroupEndpointFakes.builder()
                        .id(groupEndpointKey)
                        .group(group)
                        .endpoint(endpoint)
                        .enableFields(fields)
                        .build()
        );

        doReturn(endpoint).when(getEndpoint).execute(endpointId);
        doReturn(fields).when(idsToFieldsMapper).toFields(fieldIds);
        doReturn(groupEndpointKey).when(groupEndpointKeyMapper).map(groupId, endpointId);

        // When
        final var result = mapper.toGroupEndpointList(requestBodies, group);

        // Then
        assertThat(result).usingRecursiveComparison().isEqualTo(expected);
    }
}
