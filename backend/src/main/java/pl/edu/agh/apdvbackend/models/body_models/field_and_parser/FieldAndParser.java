package pl.edu.agh.apdvbackend.models.body_models.field_and_parser;

import io.swagger.v3.oas.annotations.media.Schema;

public record FieldAndParser(
        @Schema(required = true) Long fieldId,
        @Schema(required = true) Long parserId,
        @Schema(required = true) String label,
        @Schema(required = true) String path
) {
}
