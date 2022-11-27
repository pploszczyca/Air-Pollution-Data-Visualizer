package pl.edu.agh.apdvbackend.models.body_models.group;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;

public record GroupEndpointRequestBody(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long endpointId,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) List<Long> fieldIds
) {
}
