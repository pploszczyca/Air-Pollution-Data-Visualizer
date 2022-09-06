package pl.edu.agh.apdvbackend.mappers.field;

import java.util.ArrayList;
import java.util.Optional;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.fakes.UnitFakes;
import pl.edu.agh.apdvbackend.fakes.body_models.field.AddFieldRequestBodyFakes;
import pl.edu.agh.apdvbackend.mappers.unit.UnitNameMapper;
import pl.edu.agh.apdvbackend.models.database.FieldType;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class FieldRequestBodyMapperTest {

    @SpyBean
    private UnitNameMapper unitNameMapper;

    @Autowired
    private FieldRequestBodyMapper mapper;

    @Test
    void ShouldMapToField() {
        // Given
        final var label = "label";
        final var fieldType = FieldType.STRING;
        final var unitName = "unitName";
        final var unit = UnitFakes.builder()
                .name(unitName)
                .build();
        final var addFieldRequestBody = AddFieldRequestBodyFakes.builder()
                .label(label)
                .fieldType(fieldType)
                .unitName(unitName)
                .build();
        final var expectedField = FieldFakes
                .builder()
                .id(null)
                .label(label)
                .fieldType(FieldType.STRING)
                .unit(unit)
                .groupEndpoint(new ArrayList<>())
                .build();

        Mockito.doReturn(unit)
                .when(unitNameMapper).toUnit(Optional.of(unitName));

        // When
        final var result = mapper.toField(addFieldRequestBody);

        // Then
        assertEquals(expectedField, result);
    }

    @Test
    void ShouldUpdateField() {
        // Given
        final var id = 1234L;
        final var label = "label";
        final var fieldType = FieldType.STRING;
        final var unitName = "unitName";
        final var unit = UnitFakes.builder()
                .name(unitName)
                .build();
        final var addFieldRequestBody = AddFieldRequestBodyFakes.builder()
                .label(label)
                .fieldType(fieldType)
                .unitName(unitName)
                .build();
        final var fieldToUpdate = FieldFakes
                .builder()
                .id(id)
                .build();
        final var expectedField = FieldFakes
                .builder()
                .id(id)
                .label(label)
                .fieldType(FieldType.STRING)
                .unit(unit)
                .groupEndpoint(new ArrayList<>())
                .build();

        Mockito.doReturn(unit)
                .when(unitNameMapper).toUnit(Optional.of(unitName));

        // When
        mapper.updateFieldBy(addFieldRequestBody, fieldToUpdate);

        // Then
        assertEquals(expectedField, fieldToUpdate);
    }
}
