package pl.edu.agh.apdvbackend.use_cases.field;

import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.database.Field;

public interface SaveNewField {
    Field execute(AddFieldBodyRequest addFieldBodyRequest);
}
