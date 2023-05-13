package pl.edu.agh.apdvbackend.models.body_models.endpoint;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParser;

public record EndpointResponseBody(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long id,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) int endpointNumber,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String label,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String sensorUrl,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) List<FieldAndParser> fieldAndParserList
) {
}
