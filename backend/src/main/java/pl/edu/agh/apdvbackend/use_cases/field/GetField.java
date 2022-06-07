package pl.edu.agh.apdvbackend.use_cases.field;

import pl.edu.agh.apdvbackend.models.Field;

public interface GetField {
    Field execute(Long fieldId);
}
