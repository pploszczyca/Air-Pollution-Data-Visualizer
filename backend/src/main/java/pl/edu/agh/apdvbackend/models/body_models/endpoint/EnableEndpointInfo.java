package pl.edu.agh.apdvbackend.models.body_models.endpoint;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.database.Field;

public record EnableEndpointInfo(
        @Schema(required = true) Long id,
        @Schema(required = true) String label,
        @Schema(required = true) int endpointNumber,
        @Schema(required = true) List<Field> enableFields,
        @Schema(required = true) Integer detailedMeasurementDays,
        @Schema(required = true) Integer approximationPrecission
) {
}
