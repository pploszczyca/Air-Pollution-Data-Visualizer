package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import pl.edu.agh.apdvbackend.models.database.EnableEndpointsForGroup;

public interface GetEnableEndpointByUserAndEndpointId {
    EnableEndpointsForGroup execute(Long userId, Long endpointId);
}
