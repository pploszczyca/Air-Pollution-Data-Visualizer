package pl.edu.agh.apdvbackend.models.body_models.group;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;

public record GroupEndpointRequestBody(
        @Schema(required = true) Long endpointId,
        @Schema(required = true) List<Long> fieldIds
) {
}
