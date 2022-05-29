package pl.edu.agh.apdvbackend.controllers.sensor.body_models;

public record EndpointData(
        double temperature,
        double pressure,
        double humidity,
        double pm1_0,
        double pm2_5,
        double pm10
) {
}
