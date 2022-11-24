package pl.edu.agh.apdvbackend.use_cases.field;

import pl.edu.agh.apdvbackend.models.body_models.field.FieldRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldResponseBody;

public interface UpdateField {
    FieldResponseBody execute(Long fieldId, FieldRequestBody fieldRequestBody);
}
