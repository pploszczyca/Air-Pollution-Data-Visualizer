package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.controllers.group.body_models.AboutGroupResponseBody;

public interface RemoveUserFromGroup {
    AboutGroupResponseBody execute(Long groupId, Long userId);
}
