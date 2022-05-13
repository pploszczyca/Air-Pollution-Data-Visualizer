package pl.edu.agh.apdvbackend.models.body_models;

public record SensorLocation(
        double alt,
        double lat,
        double lon,
        String name
) {
}
