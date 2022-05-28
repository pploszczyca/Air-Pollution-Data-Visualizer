package pl.edu.agh.apdvbackend.models.body_models.sensors;

public record SensorInfo(
        String label,
        String id,
        SensorLocation sensorLocation
) {
}
