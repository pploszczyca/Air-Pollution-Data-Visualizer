package pl.edu.agh.apdvbackend.controllers.endpoint.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record UserEndpointResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) int endpointNumber,
        @Schema(required = true) String label
) {
}
