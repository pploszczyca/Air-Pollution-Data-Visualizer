package pl.edu.agh.apdvbackend.controllers.group.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record ShortGroupInfoResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) String name
) {
}
