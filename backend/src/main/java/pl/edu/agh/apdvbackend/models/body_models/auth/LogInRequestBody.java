package pl.edu.agh.apdvbackend.models.body_models.auth;

import io.swagger.v3.oas.annotations.media.Schema;

public record LogInRequestBody(
        @Schema(required = true) String email,
        @Schema(required = true) String password
) {
}
