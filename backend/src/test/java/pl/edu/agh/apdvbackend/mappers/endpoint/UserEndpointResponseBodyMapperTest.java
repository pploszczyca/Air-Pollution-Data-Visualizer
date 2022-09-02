package pl.edu.agh.apdvbackend.mappers.endpoint;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.EndpointFakes;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class UserEndpointResponseBodyMapperTest {

    @Autowired
    private UserEndpointResponseBodyMapper mapper;

    @Test
    public void ShouldMapToResponseBody() {
        // Given
        final var endpointId = 324L;
        final var endpointNumber = 420;
        final var label = "endpoint label";
        final var endpoint = EndpointFakes.builder()
                .id(endpointId)
                .endpointNumber(endpointNumber)
                .label(label)
                .build();
        final var expected = new UserEndpointResponseBody(endpointId, endpointNumber, label);

        // When
        final var result = mapper.toResponseBody(endpoint);

        // Then
        assertEquals(expected, result);
    }

    @Test
    public void ShouldMapToResponseBodyList() {
        // Given
        final var endpointId = 324L;
        final var endpointNumber = 420;
        final var label = "endpoint label";
        final var endpoint = EndpointFakes.builder()
                .id(endpointId)
                .endpointNumber(endpointNumber)
                .label(label)
                .build();
        final var expected = List.of(new UserEndpointResponseBody(endpointId, endpointNumber, label));

        // When
        final var result = mapper.toResponseBodyList(List.of(endpoint));

        // Then
        assertEquals(expected, result);
    }
}
