package pl.edu.agh.apdvbackend.models.body_models.field;

import io.swagger.v3.oas.annotations.media.Schema;
import pl.edu.agh.apdvbackend.models.database.FieldType;
import pl.edu.agh.apdvbackend.models.database.Unit;

public record FieldWithoutId(
        @Schema(required = true) String label,
        @Schema(required = true) FieldType fieldType,
        @Schema(required = true) Unit unit
) {
}
