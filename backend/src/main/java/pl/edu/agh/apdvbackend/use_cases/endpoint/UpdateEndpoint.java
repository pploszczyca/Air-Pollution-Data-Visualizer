package pl.edu.agh.apdvbackend.use_cases.endpoint;

import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;

public interface UpdateEndpoint {
    EndpointResponseBody execute(EndpointRequestBody endpointRequestBody, Long endpointId);
}
