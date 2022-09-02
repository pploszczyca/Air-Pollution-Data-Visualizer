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
import pl.edu.agh.apdvbackend.fakes.body_models.field_and_parser.FieldAndParserFakes;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldParserMapMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class EndpointResponseBodyMapperTest {

    @MockBean
    private FieldParserMapMapper fieldParserMapMapper;

    @Autowired
    private EndpointResponseBodyMapper mapper;

    @Test
    public void OnMapFieldParserMap_ShouldInvokeFieldParserMapper() {
        // Given
        final Map<Field, FieldParser> fieldParserMap = Collections.emptyMap();
        final var endpoint = EndpointFakes.builder()
                .fieldParserMap(fieldParserMap)
                .build();

        // When
        mapper.mapFieldParserMap(endpoint);

        // Then
        Mockito.verify(fieldParserMapMapper).toFieldAndParserList(fieldParserMap);
    }

    @Test
    public void ShouldMapToResponseBody() {
        // Given
        final var id = 45L;
        final var endpointNumber = 23;
        final var label = "label";
        final var sensorUrl = "sensorUrl";
        final Map<Field, FieldParser> fieldParserMap = Collections.emptyMap();
        final var fieldAndParserList = List.of(FieldAndParserFakes.builder().build());
        final var endpoint = EndpointFakes.builder()
                .id(id)
                .endpointNumber(endpointNumber)
                .label(label)
                .sensorUrl(sensorUrl)
                .fieldParserMap(fieldParserMap)
                .build();
        final var expectedResult = new EndpointResponseBody(id, endpointNumber, label, sensorUrl, fieldAndParserList);

        Mockito.doReturn(fieldAndParserList)
                .when(fieldParserMapMapper).toFieldAndParserList(fieldParserMap);

        // When
        final var result = mapper.toResponseBody(endpoint);

        // Then
        assertEquals(expectedResult, result);
    }

    @Test
    public void ShouldMapToResponseBodyList() {
        // Given
        final var id = 45L;
        final var endpointNumber = 23;
        final var label = "label";
        final var sensorUrl = "sensorUrl";
        final Map<Field, FieldParser> fieldParserMap = Collections.emptyMap();
        final var fieldAndParserList = List.of(FieldAndParserFakes.builder().build());
        final var endpoint = EndpointFakes.builder()
                .id(id)
                .endpointNumber(endpointNumber)
                .label(label)
                .sensorUrl(sensorUrl)
                .fieldParserMap(fieldParserMap)
                .build();
        final var expectedResult = List.of(
                new EndpointResponseBody(id, endpointNumber, label, sensorUrl, fieldAndParserList)
        );

        Mockito.doReturn(fieldAndParserList)
                .when(fieldParserMapMapper).toFieldAndParserList(fieldParserMap);

        // When
        final var result = mapper.toResponseBodyList(List.of(endpoint));

        // Then
        assertEquals(expectedResult, result);
    }
}
