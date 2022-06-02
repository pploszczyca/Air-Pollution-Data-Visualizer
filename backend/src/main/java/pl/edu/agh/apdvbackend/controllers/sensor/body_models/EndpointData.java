package pl.edu.agh.apdvbackend.controllers.sensor.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record EndpointData(
        @Schema(required = true) double temperature,
        @Schema(required = true) double pressure,
        @Schema(required = true) double humidity,
        @Schema(required = true) double pm1_0,
        @Schema(required = true) double pm2_5,
        @Schema(required = true) double pm10,
        @Schema(required = true) String timestamp
) {
}
