package pl.edu.agh.apdvbackend.models.body_models.user;

import io.swagger.v3.oas.annotations.media.Schema;

public record AddUserRequestBody(
        @Schema(required = true) String name,
        @Schema(required = true) String email
) {
}
