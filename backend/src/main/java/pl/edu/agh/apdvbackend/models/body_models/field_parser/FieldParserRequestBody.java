package pl.edu.agh.apdvbackend.models.body_models.field_parser;

import io.swagger.v3.oas.annotations.media.Schema;

public record FieldParserRequestBody(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String path
) {
}
