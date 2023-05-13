package pl.edu.agh.apdvbackend.models.body_models.field_and_parser;

import io.swagger.v3.oas.annotations.media.Schema;

public record FieldAndParser(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long fieldId,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long parserId,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String label,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String path
) {
}
