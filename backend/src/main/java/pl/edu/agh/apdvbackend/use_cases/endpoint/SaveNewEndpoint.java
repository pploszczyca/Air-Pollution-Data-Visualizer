package pl.edu.agh.apdvbackend.use_cases.endpoint;

import pl.edu.agh.apdvbackend.controllers.sensor.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.Endpoint;

public interface SaveNewEndpoint {
    Endpoint execute(AddEndpointRequestBody addEndpointRequestBody);
}
