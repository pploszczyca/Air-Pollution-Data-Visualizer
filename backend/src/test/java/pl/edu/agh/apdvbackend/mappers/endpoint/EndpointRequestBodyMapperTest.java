package pl.edu.agh.apdvbackend.mappers.endpoint;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import pl.edu.agh.apdvbackend.fakes.EndpointFakes;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldAndParserKeyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParserKey;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class EndpointRequestBodyMapperTest {

    @MockBean
    private FieldAndParserKeyMapper fieldAndParserKeyMapper;

    @Autowired
    private EndpointRequestBodyMapper mapper;

    @Test
    public void ShouldMapToEndpoint() {
        // Given
        final var endpointNumber = 634;
        final var label = "label";
        final var sensorUrl = "sensor.url.pl";
        final List<FieldAndParserKey> fieldAndParserKeys = Collections.emptyList();
        final Map<Field, FieldParser> fieldParserMap = Collections.emptyMap();
        final var requestBody = new EndpointRequestBody(endpointNumber, label, sensorUrl, fieldAndParserKeys);
        final var expected = EndpointFakes.builder()
                .id(null)
                .endpointNumber(endpointNumber)
                .label(label)
                .sensorUrl(sensorUrl)
                .fieldParserMap(fieldParserMap)
                .build();

        Mockito.doReturn(fieldParserMap)
                .when(fieldAndParserKeyMapper).toMap(fieldAndParserKeys);

        // When
        final var result = mapper.toEndpoint(requestBody);

        // Then
        assertThat(result).usingRecursiveComparison().isEqualTo(expected);
    }

    @Test
    public void ShouldUpdateEndpoint() {
        // Given
        final var endpointId = 1243L;
        final var endpointNumber = 634;
        final var label = "label";
        final var sensorUrl = "sensor.url.pl";
        final List<FieldAndParserKey> fieldAndParserKeys = Collections.emptyList();
        final Map<Field, FieldParser> fieldParserMap = Collections.emptyMap();
        final var requestBody = new EndpointRequestBody(endpointNumber, label, sensorUrl, fieldAndParserKeys);
        final var endpointToUpdate = EndpointFakes.builder()
                .id(endpointId)
                .build();
        final var expected = EndpointFakes.builder()
                .id(endpointId)
                .endpointNumber(endpointNumber)
                .label(label)
                .sensorUrl(sensorUrl)
                .fieldParserMap(fieldParserMap)
                .build();

        Mockito.doReturn(fieldParserMap)
                .when(fieldAndParserKeyMapper).toMap(fieldAndParserKeys);

        // When
        mapper.updateEndpoint(requestBody, endpointToUpdate);

        // Then
        assertThat(endpointToUpdate).usingRecursiveComparison().isEqualTo(expected);
    }
}
