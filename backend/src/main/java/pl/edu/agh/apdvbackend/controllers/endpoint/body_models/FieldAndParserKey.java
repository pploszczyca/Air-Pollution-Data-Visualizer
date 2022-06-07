package pl.edu.agh.apdvbackend.controllers.endpoint.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record FieldAndParserKey(
        @Schema(required = true) Long fieldId,
        @Schema(required = true) Long parserId
) {
}
