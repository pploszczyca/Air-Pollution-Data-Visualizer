package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupEndpointRequestBody;

public interface ChangeEnableEndpointsInGroup {
    AboutGroupResponseBody execute(
            List<GroupEndpointRequestBody> groupEndpointRequestBodyList,
            Long groupId
    );
}
