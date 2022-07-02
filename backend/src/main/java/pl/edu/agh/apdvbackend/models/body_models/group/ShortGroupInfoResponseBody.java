package pl.edu.agh.apdvbackend.models.body_models.group;

import io.swagger.v3.oas.annotations.media.Schema;

public record ShortGroupInfoResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) String name
) {
}
