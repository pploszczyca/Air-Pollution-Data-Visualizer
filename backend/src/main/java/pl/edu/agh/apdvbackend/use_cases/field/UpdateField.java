package pl.edu.agh.apdvbackend.use_cases.field;

import pl.edu.agh.apdvbackend.models.body_models.field.FieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;

public interface UpdateField {
    Field execute(Long fieldId, FieldRequestBody fieldRequestBody);
}
