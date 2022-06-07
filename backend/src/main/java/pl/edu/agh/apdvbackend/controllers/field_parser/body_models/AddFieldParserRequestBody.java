package pl.edu.agh.apdvbackend.controllers.field_parser.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record AddFieldParserRequestBody(
        @Schema(required = true) String path
) {
}
