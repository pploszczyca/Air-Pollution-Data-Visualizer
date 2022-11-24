package pl.edu.agh.apdvbackend.mappers.field;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldResponseBody;
import pl.edu.agh.apdvbackend.models.database.FieldType;
import pl.edu.agh.apdvbackend.models.database.Unit;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class FieldResponseBodyMapperTest {

    @Autowired
    private FieldResponseBodyMapper fieldResponseBodyMapper;

    @Test
    void ShouldMapToResponseBody() {
        final var id = 42L;
        final var label = "label";
        final var fieldType = FieldType.STRING;
        final var unit = mock(Unit.class);
        final var field = FieldFakes
                .builder()
                .id(id)
                .label(label)
                .fieldType(fieldType)
                .unit(unit)
                .build();
        final var expected = new FieldResponseBody(id, label, fieldType, unit);

        final var result = fieldResponseBodyMapper.toResponseBody(field);

        assertEquals(expected, result);
    }

    @Test
    void ShouldMapToResponseBodyList() {
        final var id = 42L;
        final var label = "label";
        final var fieldType = FieldType.STRING;
        final var unit = mock(Unit.class);
        final var field = FieldFakes
                .builder()
                .id(id)
                .label(label)
                .fieldType(fieldType)
                .unit(unit)
                .build();
        final var expected = List.of(new FieldResponseBody(id, label, fieldType, unit));

        final var result = fieldResponseBodyMapper.toResponseBodyList(List.of(field));

        assertEquals(expected, result);
    }
}
