package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;


public interface GetEnableEndpointByUserAndEndpointId {
    GroupEndpoint execute(Long userId, Long endpointId);
}
