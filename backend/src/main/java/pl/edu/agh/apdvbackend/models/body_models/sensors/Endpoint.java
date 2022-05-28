package pl.edu.agh.apdvbackend.models.body_models.sensors;

import java.util.List;

public record Endpoint(
        Long id,
        String label,
        List<EndpointData> endpointDataList
) {
}
