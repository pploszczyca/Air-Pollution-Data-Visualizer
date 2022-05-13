package pl.edu.agh.apdvbackend.models.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record DataHubDataRequest(
        @Schema(required = true, example = "/pl/datasets/env-mon-outskirts-of-krakow/endpoints/87/data/")
        String url
) {
}
