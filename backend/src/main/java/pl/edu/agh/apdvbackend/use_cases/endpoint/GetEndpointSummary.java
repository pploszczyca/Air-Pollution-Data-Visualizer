package pl.edu.agh.apdvbackend.use_cases.endpoint;

import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;

public interface GetEndpointSummary {
    EndpointResponseBody execute(Long endpointId);
}
