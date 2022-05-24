package pl.edu.agh.apdvbackend.models.body_models;

public record Response<T>(
        T data,
        String error
) {
    public static <P> Response<P> withOkStatus(P data) {
        return new Response<>(data, null);
    }

    public static <P> Response<P> withError(String error) {
        return new Response<>(null, error);
    }
}
