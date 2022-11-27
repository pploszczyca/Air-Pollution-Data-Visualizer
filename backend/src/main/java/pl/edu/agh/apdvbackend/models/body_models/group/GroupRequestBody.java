package pl.edu.agh.apdvbackend.models.body_models.group;

import io.swagger.v3.oas.annotations.media.Schema;

public record GroupRequestBody(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String name
) {
}
