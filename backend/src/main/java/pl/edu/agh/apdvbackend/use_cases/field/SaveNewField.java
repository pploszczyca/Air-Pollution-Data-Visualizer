package pl.edu.agh.apdvbackend.use_cases.field;

import pl.edu.agh.apdvbackend.controllers.field.body_models.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.Field;

public interface SaveNewField {
    Field execute(AddFieldBodyRequest addFieldBodyRequest);
}
