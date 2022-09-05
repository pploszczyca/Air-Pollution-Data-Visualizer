package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldType;

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
}
