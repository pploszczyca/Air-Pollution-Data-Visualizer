package pl.edu.agh.apdvbackend.models.body_models.endpoint;

import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldWithoutId;

public record EndpointData(
        @Schema(required = true) List<FieldWithoutId> fields,
        @Schema(required = true) List<ObjectNode> endpointData
) {
}
