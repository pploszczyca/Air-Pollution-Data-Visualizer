package pl.edu.agh.apdvbackend.models.body_models.unit_converter;

import io.swagger.v3.oas.annotations.media.Schema;
import pl.edu.agh.apdvbackend.models.database.MathOperation;

public record UnitConverterRequestBody(
        @Schema(required = true) Long fromUnitId,
        @Schema(required = true) Long toUnitId,
        @Schema(required = true) int calculationStep,
        @Schema(required = true) MathOperation mathOperation,
        @Schema(required = true) Double value
) {
}
