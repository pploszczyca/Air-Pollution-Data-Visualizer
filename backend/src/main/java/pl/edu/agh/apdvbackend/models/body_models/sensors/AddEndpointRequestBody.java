package pl.edu.agh.apdvbackend.models.body_models.sensors;

import io.swagger.v3.oas.annotations.media.Schema;

public record AddEndpointRequestBody(
        @Schema(required = true) int endpointNumber,
        @Schema(required = true) String label,
        @Schema(required = true) String sensorUrl
) {
}
