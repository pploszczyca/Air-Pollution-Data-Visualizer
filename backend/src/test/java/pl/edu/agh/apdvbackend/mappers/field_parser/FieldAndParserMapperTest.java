package pl.edu.agh.apdvbackend.mappers.field_parser;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.fakes.FieldParserFakes;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParser;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class FieldAndParserMapperTest {

    @Autowired
    private FieldAndParserMapper mapper;

    @Test
    public void shouldCombineFieldAndParser() {
        // Given
        final var fieldId = 32L;
        final var parserId = 23L;
        final var label = "label";
        final var path = "/path";
        final var field = FieldFakes.builder()
                .id(fieldId)
                .label(label)
                .build();
        final var fieldParser = FieldParserFakes.builder()
                .id(parserId)
                .path(path)
                .build();
        final var expectedResult = new FieldAndParser(fieldId, parserId, label, path);

        // When
        final var result = mapper.combineFieldAndParser(field, fieldParser);

        // Then
        assertEquals(expectedResult, result);
    }
}
