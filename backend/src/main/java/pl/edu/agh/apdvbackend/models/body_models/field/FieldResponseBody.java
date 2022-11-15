package pl.edu.agh.apdvbackend.models.body_models.field;

import pl.edu.agh.apdvbackend.models.database.FieldType;
import pl.edu.agh.apdvbackend.models.database.Unit;

public record FieldResponseBody(
        Long id,
        String label,
        FieldType fieldType,
        Unit unit
) {
}
