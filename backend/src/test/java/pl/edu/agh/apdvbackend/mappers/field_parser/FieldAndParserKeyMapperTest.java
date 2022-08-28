package pl.edu.agh.apdvbackend.mappers.field_parser;

import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.fakes.FieldParserFakes;
import pl.edu.agh.apdvbackend.fakes.body_models.field_and_parser.FieldAndParserKeyFakes;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;
import pl.edu.agh.apdvbackend.use_cases.field_parser.GetFieldParser;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class FieldAndParserKeyMapperTest {

    @SpyBean
    private GetField getField;

    @SpyBean
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
        assertEquals(expectedResult, result);
    }
}
