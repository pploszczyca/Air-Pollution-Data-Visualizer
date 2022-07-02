package pl.edu.agh.apdvbackend.use_cases.endpoint;

import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointData;

public interface GetUserEndpointDataWithFields {
    EndpointData execute(Long userId, Long endpointId, Long limit, Long offset);
}
