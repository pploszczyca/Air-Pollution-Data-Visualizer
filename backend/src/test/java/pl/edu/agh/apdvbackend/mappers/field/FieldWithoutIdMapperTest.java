package pl.edu.agh.apdvbackend.mappers.field;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldWithoutId;
import pl.edu.agh.apdvbackend.models.database.FieldType;
import pl.edu.agh.apdvbackend.models.database.Unit;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class FieldWithoutIdMapperTest {

    @Autowired
    private FieldWithoutIdMapper mapper;

    @Test
    public void ShouldMapToFieldWithoutId() {
        // Given
        final var label = "label";
        final var fieldType = FieldType.STRING;
        final var unit = Mockito.mock(Unit.class);
        final var field = FieldFakes.builder()
                .label(label)
                .fieldType(fieldType)
                .unit(unit)
                .build();
        final var expectedFieldWithoutId = new FieldWithoutId(label, fieldType, unit);

        // When
        final var result = mapper.fieldToWithoutId(field);

        // Then
        assertEquals(expectedFieldWithoutId, result);
    }

    @Test
    public void ShouldMapToFieldWithoutIdList() {
        // Given
        final var label = "label";
        final var fieldType = FieldType.STRING;
        final var unit = Mockito.mock(Unit.class);
        final var field = FieldFakes.builder()
                .label(label)
                .fieldType(fieldType)
                .unit(unit)
                .build();
        final var fields = List.of(field);
        final var expectedFieldsWithoutId = List.of(new FieldWithoutId(label, fieldType, unit));

        // When
        final var result = mapper.fieldsToWithoutIdList(fields);

        // Then
        assertEquals(expectedFieldsWithoutId, result);
    }
}
