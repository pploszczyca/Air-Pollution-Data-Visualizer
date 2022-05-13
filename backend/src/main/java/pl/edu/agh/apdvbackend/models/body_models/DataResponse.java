package pl.edu.agh.apdvbackend.models.body_models;

public record DataResponse(
        double temperature,
        double pressure,
        double humidity,
        double pm1_0,
        double pm2_5,
        double pm10
) {
}
