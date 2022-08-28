package pl.edu.agh.apdvbackend.use_cases.field;

import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldType;
import pl.edu.agh.apdvbackend.models.database.Unit;

public interface SaveNewField {
    Field execute(AddFieldRequestBody addFieldRequestBody);
}
