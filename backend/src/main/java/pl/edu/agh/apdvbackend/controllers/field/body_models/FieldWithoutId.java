package pl.edu.agh.apdvbackend.controllers.field.body_models;

import io.swagger.v3.oas.annotations.media.Schema;
import pl.edu.agh.apdvbackend.models.FieldType;
import pl.edu.agh.apdvbackend.models.Unit;

public record FieldWithoutId(
        @Schema(required = true) String label,
        @Schema(required = true) FieldType fieldType,
        @Schema(required = true) Unit unit
) {
}
