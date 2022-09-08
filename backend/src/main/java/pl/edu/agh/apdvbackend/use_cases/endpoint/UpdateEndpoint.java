package pl.edu.agh.apdvbackend.use_cases.endpoint;

import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

public interface UpdateEndpoint {
    Endpoint execute(EndpointRequestBody endpointRequestBody, Long endpointId);
}
