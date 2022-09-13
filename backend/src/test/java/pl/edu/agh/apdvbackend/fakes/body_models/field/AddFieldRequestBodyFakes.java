package pl.edu.agh.apdvbackend.fakes.body_models.field;

import java.util.Optional;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldType;

public class AddFieldRequestBodyFakes {
    @Builder
    private static FieldRequestBody buildNewAddFieldRequestBody(
            String label,
            FieldType fieldType,
            String unitName
    ) {
        return new FieldRequestBody(
                getOrElse(label, "dummy label"),
                getOrElse(fieldType, FieldType.STRING),
                getOrElse(Optional.of(unitName), Optional.of("dummy unit name"))
        );
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
