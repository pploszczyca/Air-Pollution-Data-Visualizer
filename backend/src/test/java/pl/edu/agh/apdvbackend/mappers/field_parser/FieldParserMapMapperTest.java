package pl.edu.agh.apdvbackend.mappers.field_parser;

import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import pl.edu.agh.apdvbackend.fakes.body_models.field_and_parser.FieldAndParserFakes;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class FieldParserMapMapperTest {
    @SpyBean
    private FieldAndParserMapper fieldAndParserMapper;

    @Autowired
    private FieldParserMapMapper mapper;

    @Test
    public void ShouldMapToList() {
        // Given
        final var field = Mockito.mock(Field.class);
        final var fieldParser = Mockito.mock(FieldParser.class);
        final var fieldAndParser = FieldAndParserFakes.builder().build();
        final var expectedResult = List.of(fieldAndParser);

        Mockito.doReturn(fieldAndParser)
                .when(fieldAndParserMapper).combineFieldAndParser(field, fieldParser);

        // When
        final var result = mapper.toFieldAndParserList(Map.of(field, fieldParser));

        // Then
        assertEquals(expectedResult, result);
    }
}
