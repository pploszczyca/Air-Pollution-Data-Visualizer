package pl.edu.agh.apdvbackend.models.body_models.auth;

import io.swagger.v3.oas.annotations.media.Schema;

public record JWTResponse(
        @Schema(required = true) String token,
        @Schema(required = true) String refreshToken
) {
}
