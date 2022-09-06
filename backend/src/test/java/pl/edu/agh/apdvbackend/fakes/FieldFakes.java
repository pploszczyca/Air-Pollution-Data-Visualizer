package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import java.util.List;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldType;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;
import pl.edu.agh.apdvbackend.models.database.Unit;

public class FieldFakes {

    public static final long FIELD_ID = 999L;

    public static Field getField() {
        final var field = new Field();
        field.setId(FIELD_ID);
        field.setLabel("dummy field label");
        field.setFieldType(FieldType.STRING);
        field.setUnit(UnitFakes.getUnit());
        field.setGroupEndpoint(Collections.emptyList());

        return field;
    }

    @Builder
    private static Field buildNewField(
            Long id,
            String label,
            FieldType fieldType,
            Unit unit,
            List<GroupEndpoint> groupEndpoint
    ) {
        final var field = new Field();
        field.setId(id);
        field.setLabel(getOrElse(label, "dummy field label"));
        field.setFieldType(getOrElse(fieldType, FieldType.STRING));
        field.setUnit(getOrElse(unit, UnitFakes.getUnit()));
        field.setGroupEndpoint(getOrElse(groupEndpoint, Collections.emptyList()));

        return field;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
