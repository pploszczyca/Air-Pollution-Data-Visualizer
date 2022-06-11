package pl.edu.agh.apdvbackend.controllers.field.body_models;

import io.swagger.v3.oas.annotations.media.Schema;
import pl.edu.agh.apdvbackend.models.FieldType;

public record AddFieldBodyRequest(
        @Schema(required = true) String label,
        @Schema(required = true) FieldType fieldType,
        @Schema(required = true) String unitName
) {
}
