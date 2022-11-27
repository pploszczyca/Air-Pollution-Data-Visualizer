package pl.edu.agh.apdvbackend.models.body_models.field;

import io.swagger.v3.oas.annotations.media.Schema;
import pl.edu.agh.apdvbackend.models.database.FieldType;
import pl.edu.agh.apdvbackend.models.database.Unit;

public record FieldWithoutId(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String label,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) FieldType fieldType,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Unit unit
) {
}
