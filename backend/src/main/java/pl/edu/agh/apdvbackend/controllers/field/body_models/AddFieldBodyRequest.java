package pl.edu.agh.apdvbackend.controllers.field.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record AddFieldBodyRequest(
        @Schema(required = true) String label
) {
}
