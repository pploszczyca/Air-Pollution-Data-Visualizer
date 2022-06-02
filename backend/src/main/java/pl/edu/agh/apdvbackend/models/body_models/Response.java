package pl.edu.agh.apdvbackend.models.body_models;

import io.swagger.v3.oas.annotations.media.Schema;

public record Response<T>(
        @Schema(required = true) T data,
        @Schema(required = true) String error
) {
    public static <P> Response<P> withOkStatus(P data) {
        return new Response<>(data, null);
    }

    public static <P> Response<P> withError(String error) {
        return new Response<>(null, error);
    }
}
