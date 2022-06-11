package pl.edu.agh.apdvbackend.controllers.endpoint.body_models;

import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.controllers.field.body_models.FieldWithoutId;

public record EndpointData(
        @Schema(required = true) List<FieldWithoutId> fields,
        @Schema(required = true) List<ObjectNode> endpointData
) {
}
