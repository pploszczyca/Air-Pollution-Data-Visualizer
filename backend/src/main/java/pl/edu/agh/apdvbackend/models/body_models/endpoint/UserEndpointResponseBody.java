package pl.edu.agh.apdvbackend.models.body_models.endpoint;

import io.swagger.v3.oas.annotations.media.Schema;

public record UserEndpointResponseBody(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long id,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) int endpointNumber,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String label
) {
}
