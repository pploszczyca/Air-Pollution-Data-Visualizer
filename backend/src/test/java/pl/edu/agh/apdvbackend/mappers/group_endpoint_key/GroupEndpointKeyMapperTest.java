package pl.edu.agh.apdvbackend.mappers.group_endpoint_key;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.GroupEndpointKeyFakes;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class GroupEndpointKeyMapperTest {

    @Autowired
    private GroupEndpointKeyMapper mapper;

    @Test
    void ShouldMap() {
        // Given
        final var groupId = 23L;
        final var endpointId = 24L;
        final var expected = GroupEndpointKeyFakes.builder()
                .groupId(groupId)
                .endpointId(endpointId)
                .build();

        // When
        final var result = mapper.map(groupId, endpointId);

        // Then
        assertEquals(expected, result);
    }
}
