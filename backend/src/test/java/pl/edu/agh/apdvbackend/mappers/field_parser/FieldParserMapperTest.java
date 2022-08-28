package pl.edu.agh.apdvbackend.mappers.field_parser;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.FieldParserFakes;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.AddFieldParserRequestBody;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class FieldParserMapperTest {

    @Autowired
    private FieldParserMapper mapper;

    @Test
    public void ShouldMapToFieldParser() {
        // Given
        final var path = "/path";
        final var requestBody = new AddFieldParserRequestBody(path);
        final var expectedFieldParser = FieldParserFakes.builder()
                .id(null)
                .path(path)
                .build();

        // When
        final var result = mapper.addRequestBodyToFieldParser(requestBody);

        // Then
        assertEquals(expectedFieldParser, result);
    }

    @Test
    public void ShouldUpdateField() {
        // Given
        final var id = 54L;
        final var path = "/new/path";
        final var requestBody = new AddFieldParserRequestBody(path);
        final var fieldToUpdate = FieldParserFakes.builder()
                .id(id)
                .path("/old/path")
                .build();
        final var expectedField = FieldParserFakes.builder()
                .id(id)
                .path(path)
                .build();

        // When
        mapper.updateFieldParserFromAddRequestBody(requestBody, fieldToUpdate);

        // Then
        assertEquals(expectedField, fieldToUpdate);
    }
}
