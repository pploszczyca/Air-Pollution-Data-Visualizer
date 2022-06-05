package pl.edu.agh.apdvbackend.controllers.group.body_models;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.Field;

public record AddEnableEndpointRequestBody(
        @Schema(required = true) Long endpointId,
        @Schema(required = true) List<Field> fields,
        @Schema(required = true) Integer detailedMeasurementDays,
        @Schema(required = true) Integer approximationPrecission) {
}
