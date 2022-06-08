package pl.edu.agh.apdvbackend.controllers.endpoint.body_models;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;

public record EndpointSummaryResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) int endpointNumber,
        @Schema(required = true) String label,
        @Schema(required = true) String sensorUrl,
        @Schema(required = true) List<FieldAndParser> fieldAndParserList
) {
}
