package pl.edu.agh.apdvbackend.models.body_models.field_parser;

import io.swagger.v3.oas.annotations.media.Schema;

public record AddFieldParserRequestBody(
        @Schema(required = true) String path
) {
}
