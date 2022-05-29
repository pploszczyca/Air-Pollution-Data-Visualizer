package pl.edu.agh.apdvbackend.controllers.sensor.body_models;

import java.util.List;

public record Endpoint(
        Long id,
        String label,
        List<EndpointData> endpointDataList
) {
}
