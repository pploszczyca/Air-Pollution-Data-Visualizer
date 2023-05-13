package pl.edu.agh.apdvbackend.models.body_models.unit_converter;

import io.swagger.v3.oas.annotations.media.Schema;
import pl.edu.agh.apdvbackend.models.database.MathOperation;

public record UnitConverterResponseBody(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long id,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long fromUnitId,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long toUnitId,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) int calculationStep,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) MathOperation mathOperation,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Double value
) {
}
