package pl.edu.agh.apdvbackend.models.body_models.endpoint;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParserKey;

public record EndpointRequestBody(
        @Schema(required = true) int endpointNumber,
        @Schema(required = true) String label,
        @Schema(required = true) String sensorUrl,
        @Schema(required = true) List<FieldAndParserKey> fieldAndParserKeys
) {
}
