package pl.edu.agh.apdvbackend.fakes.body_models.field;

import java.util.Optional;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldType;

public class AddFieldRequestBodyFakes {
    @Builder
    public static AddFieldRequestBody buildNewAddFieldRequestBody(
            String label,
            FieldType fieldType,
            String unitName
    ) {
        return new AddFieldRequestBody(label, fieldType, Optional.of(unitName));
    }
}
