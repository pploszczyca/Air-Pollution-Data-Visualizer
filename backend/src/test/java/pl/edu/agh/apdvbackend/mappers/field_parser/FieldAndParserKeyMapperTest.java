package pl.edu.agh.apdvbackend.mappers.field_parser;

import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.fakes.FieldParserFakes;
import pl.edu.agh.apdvbackend.fakes.body_models.field_and_parser.FieldAndParserKeyFakes;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;
import pl.edu.agh.apdvbackend.use_cases.field_parser.GetFieldParser;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class FieldAndParserKeyMapperTest {

    @MockBean
    private GetField getField;

    @MockBean
    private GetFieldParser getFieldParser;

    @Autowired
    private FieldAndParserKeyMapper mapper;

    @Test
    public void shouldMap() {
        // Given
        final var fieldId = 65L;
        final var parserId = 87L;
        final var fieldAndParserKey = FieldAndParserKeyFakes.builder()
                .fieldId(fieldId)
                .parserId(parserId)
                .build();
        final var field = FieldFakes.builder()
                .id(fieldId)
                .build();
        final var fieldParser = FieldParserFakes.builder()
                .id(parserId)
                .build();
        final var expectedResult = Map.of(field, fieldParser);

        Mockito.doReturn(field)
                .when(getField).execute(fieldId);
        Mockito.doReturn(fieldParser)
                .when(getFieldParser).execute(parserId);

        // When
        final var result = mapper.toMap(List.of(fieldAndParserKey));

        // Then
        assertThat(result).usingRecursiveComparison().isEqualTo(expectedResult);
    }
}
