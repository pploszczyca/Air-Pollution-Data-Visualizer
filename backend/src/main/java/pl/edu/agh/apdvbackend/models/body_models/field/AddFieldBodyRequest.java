package pl.edu.agh.apdvbackend.models.body_models.field;

import io.swagger.v3.oas.annotations.media.Schema;
import pl.edu.agh.apdvbackend.models.database.FieldType;

public record AddFieldBodyRequest(
        @Schema(required = true) String label,
        @Schema(required = true) FieldType fieldType,
        String unitName
) {
}
