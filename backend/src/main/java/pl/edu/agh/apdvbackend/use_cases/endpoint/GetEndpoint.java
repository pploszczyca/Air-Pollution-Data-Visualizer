package pl.edu.agh.apdvbackend.use_cases.endpoint;

import pl.edu.agh.apdvbackend.models.Endpoint;

public interface GetEndpoint {
    Endpoint execute(Long endpointId);
}
