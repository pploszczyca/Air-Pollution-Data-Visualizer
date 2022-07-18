package pl.edu.agh.apdvbackend.models.body_models.endpoint;

import io.swagger.v3.oas.annotations.media.Schema;

public record UserEndpointResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) int endpointNumber,
        @Schema(required = true) String label
) {
}
