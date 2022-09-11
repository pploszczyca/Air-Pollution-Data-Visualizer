package pl.edu.agh.apdvbackend.mappers.group_endpoint;

import java.util.Collections;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.EndpointFakes;
import pl.edu.agh.apdvbackend.fakes.GroupEndpointFakes;
import pl.edu.agh.apdvbackend.fakes.GroupEndpointKeyFakes;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Field;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class GroupEndpointResponseBodyMapperTest {

    @Autowired
    private GroupEndpointResponseBodyMapper mapper;

    @Test
    public void ShouldMapToResponseBody() {
        // Given
        final var endpointId = 324L;
        final var label = "label";
        final var endpointNumber = 2314;
        final List<Field> enableFields = Collections.emptyList();
        final var detailedMeasurementDays = 324;
        final var approximationPrecission = 213;
        final var endpoint = EndpointFakes.builder()
                .id(endpointId)
                .label(label)
                .endpointNumber(endpointNumber)
                .build();
        final var groupEndpointKey = GroupEndpointKeyFakes.builder()
                .endpointId(endpointId)
                .build();
        final var groupEndpoint = GroupEndpointFakes.builder()
                .id(groupEndpointKey)
                .endpoint(endpoint)
                .enableFields(enableFields)
                .detailedMeasurementDays(detailedMeasurementDays)
                .approximationPrecission(approximationPrecission)
                .build();
        final var expected = new GroupEndpointResponseBody(
                endpointId, label, endpointNumber, enableFields, detailedMeasurementDays, approximationPrecission
        );

        // When
        final var result = mapper.toResponseBody(groupEndpoint);

        // Then
        assertEquals(expected, result);
    }

    @Test
    public void ShouldMapToResponseBodyList() {
        // Given
        final var endpointId = 324L;
        final var label = "label";
        final var endpointNumber = 2314;
        final List<Field> enableFields = Collections.emptyList();
        final var detailedMeasurementDays = 324;
        final var approximationPrecission = 213;
        final var endpoint = EndpointFakes.builder()
                .id(endpointId)
                .label(label)
                .endpointNumber(endpointNumber)
                .build();
        final var groupEndpointKey = GroupEndpointKeyFakes.builder()
                .endpointId(endpointId)
                .build();
        final var groupEndpoint = GroupEndpointFakes.builder()
                .id(groupEndpointKey)
                .endpoint(endpoint)
                .enableFields(enableFields)
                .detailedMeasurementDays(detailedMeasurementDays)
                .approximationPrecission(approximationPrecission)
                .build();
        final var expected = List.of(new GroupEndpointResponseBody(
                endpointId, label, endpointNumber, enableFields, detailedMeasurementDays, approximationPrecission
        ));

        // When
        final var result = mapper.toResponseBodyList(List.of(groupEndpoint));

        // Then
        assertEquals(expected, result);
    }
}
