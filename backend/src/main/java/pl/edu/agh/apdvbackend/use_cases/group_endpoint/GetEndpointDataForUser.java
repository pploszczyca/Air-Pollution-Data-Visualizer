package pl.edu.agh.apdvbackend.use_cases.group_endpoint;

import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;

public interface GetEndpointDataForUser {
    GroupEndpointResponseBody execute(Long userId, Long endpointId);
}
