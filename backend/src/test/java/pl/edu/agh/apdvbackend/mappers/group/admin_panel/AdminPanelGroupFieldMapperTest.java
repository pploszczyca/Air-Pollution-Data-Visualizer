package pl.edu.agh.apdvbackend.mappers.group.admin_panel;

import java.util.Collections;
import java.util.List;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.fakes.UnitFakes;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldType;

@SpringBootTest
class AdminPanelGroupFieldMapperTest {

    @Autowired
    private AdminPanelGroupFieldMapper mapper;

    @Test
    public void onToFieldList_ShouldRunToField() {
        // Given
        final var id = 1L;
        final var label = "label";
        final var fieldType = FieldType.FOR_CHART;
        final var unitName = "unitName";
        final var isBelongingToGroup = false;

        final var unit = UnitFakes.getUnit();
        unit.setName(unitName);

        final List<Field> enableFields = Collections.emptyList();
        final var field = FieldFakes.getField();
        field.setId(id);
        field.setLabel(label);
        field.setFieldType(fieldType);
        field.setUnit(unit);
        final var fields = List.of(field);

        final var expected = List.of(
                new AdminPanelGroupResponseBody.Endpoint.Field(
                        id,
                        label,
                        fieldType,
                        unitName,
                        isBelongingToGroup
                )
        );

        // When
        final var result = mapper.toFieldList(fields, enableFields);

        // Then
        assertEquals(expected, result);
    }

    @Test
    public void onToField_ShouldMapToAdminField() {
        // Given
        final var id = 1L;
        final var label = "label";
        final var fieldType = FieldType.FOR_CHART;
        final var unitName = "unitName";
        final var isBelongingToGroup = false;

        final var unit = UnitFakes.getUnit();
        unit.setName(unitName);

        final List<Field> enableFields = Collections.emptyList();
        final var field = FieldFakes.getField();
        field.setId(id);
        field.setLabel(label);
        field.setFieldType(fieldType);
        field.setUnit(unit);

        final var expected = new AdminPanelGroupResponseBody.Endpoint.Field(
                id,
                label,
                fieldType,
                unitName,
                isBelongingToGroup
        );

        // When
        final var result = mapper.toField(field, enableFields);

        // Then
        assertEquals(expected, result);
    }

    @Nested
    class IsFieldBelongsToGroupTest {
        @Test
        public void shouldReturnFalse_IfFieldNotBelongsToEnableFields() {
            // Given
            final var field = FieldFakes.getField();
            final List<Field> enableFields = Collections.emptyList();

            // When
            final var result =
                    mapper.isFieldBelongsToGroup(field, enableFields);

            // Then
            assertFalse(result);
        }

        @Test
        public void shouldReturnTrue_IfFieldBelongsToEnableFields() {
            // Given
            final var field = FieldFakes.getField();
            final List<Field> enableFields = List.of(field);

            // When
            final var result =
                    mapper.isFieldBelongsToGroup(field, enableFields);

            // Then
            assertTrue(result);
        }
    }
}
