package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import java.util.List;
import pl.edu.agh.apdvbackend.models.EnableEndpointsForGroup;

public interface GetEnableEndpointsByGroupId {
    List<EnableEndpointsForGroup> execute(Long groupId);
}
