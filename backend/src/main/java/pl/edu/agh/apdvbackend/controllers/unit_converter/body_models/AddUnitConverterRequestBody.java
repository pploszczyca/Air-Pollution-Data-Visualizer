package pl.edu.agh.apdvbackend.controllers.unit_converter.body_models;

import io.swagger.v3.oas.annotations.media.Schema;
import pl.edu.agh.apdvbackend.models.MathOperation;

public record AddUnitConverterRequestBody(
        @Schema(required = true) Long fromUnitId,
        @Schema(required = true) Long toUnitId,
        @Schema(required = true) int calculationStep,
        @Schema(required = true) MathOperation mathOperation,
        @Schema(required = true) Double value
) {
}
