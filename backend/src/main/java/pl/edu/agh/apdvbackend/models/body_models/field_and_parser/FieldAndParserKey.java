package pl.edu.agh.apdvbackend.models.body_models.field_and_parser;

import io.swagger.v3.oas.annotations.media.Schema;

public record FieldAndParserKey(
        @Schema(required = true) Long fieldId,
        @Schema(required = true) Long parserId
) {
}
