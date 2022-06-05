package pl.edu.agh.apdvbackend.models.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record ShortGroupInfo(
        @Schema(required = true) Long id,
        @Schema(required = true) String name
) {
}
