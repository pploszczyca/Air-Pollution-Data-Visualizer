package pl.edu.agh.apdvbackend.use_cases.field;

import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;

public interface SaveNewField {
    Field execute(AddFieldRequestBody addFieldRequestBody);
}
