package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

public interface GetEnableEndpointByGroupAndEndpointIds {
    GroupEndpoint execute(Long groupId, Long endpointId);
}
