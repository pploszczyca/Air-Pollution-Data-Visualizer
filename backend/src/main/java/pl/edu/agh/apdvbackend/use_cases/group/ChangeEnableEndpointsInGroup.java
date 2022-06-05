package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AddEnableEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.Group;

public interface ChangeEnableEndpointsInGroup {
    Group execute(
            List<AddEnableEndpointRequestBody> addEnableEndpointRequestBodyList, Long groupId);
}
