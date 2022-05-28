package pl.edu.agh.apdvbackend.models.body_models.sensors;

public record SensorLocation(
        double alt,
        double lat,
        double lon,
        String name
) {
}
