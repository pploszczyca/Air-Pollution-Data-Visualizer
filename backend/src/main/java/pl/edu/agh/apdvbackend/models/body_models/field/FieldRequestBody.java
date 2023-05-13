package pl.edu.agh.apdvbackend.models.body_models.field;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.Optional;
import pl.edu.agh.apdvbackend.models.database.FieldType;

public record FieldRequestBody(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String label,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) FieldType fieldType,
        Optional<String> unitName
) {
}
