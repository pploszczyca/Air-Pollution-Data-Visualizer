package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;

public interface GetEndpointDataForUser {
    GroupEndpointResponseBody execute(Long endpointId, Long userId);
}
