package pl.edu.agh.apdvbackend.use_cases.endpoint;

import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointWithField;

public interface GetUserEndpointDataWithFields {
    EndpointWithField execute(Long userId, Long endpointId, Long limit,
                              Long offset);
}
