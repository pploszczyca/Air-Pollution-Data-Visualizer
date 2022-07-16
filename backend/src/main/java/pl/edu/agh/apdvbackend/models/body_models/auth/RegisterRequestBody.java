package pl.edu.agh.apdvbackend.models.body_models.auth;

import io.swagger.v3.oas.annotations.media.Schema;

public record RegisterRequestBody(
        @Schema(required = true) String name,
        @Schema(required = true) String email,
        @Schema(required = true) String password
) {
}
