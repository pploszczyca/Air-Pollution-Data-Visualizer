package pl.edu.agh.apdvbackend.controllers.sensor.body_models;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;

public record Endpoint(
        @Schema(required = true) Long id,
        @Schema(required = true) String label,
        @Schema(required = true) List<EndpointData> endpointDataList
) {
}
