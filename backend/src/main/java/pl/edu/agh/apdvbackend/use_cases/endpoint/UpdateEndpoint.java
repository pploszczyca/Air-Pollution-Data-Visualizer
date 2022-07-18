package pl.edu.agh.apdvbackend.use_cases.endpoint;

import pl.edu.agh.apdvbackend.models.body_models.endpoint.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

public interface UpdateEndpoint {
    Endpoint execute(AddEndpointRequestBody addEndpointRequestBody,
                     Long endpointId);
}
