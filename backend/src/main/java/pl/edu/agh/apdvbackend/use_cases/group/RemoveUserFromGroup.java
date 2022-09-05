package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;

public interface RemoveUserFromGroup {
    AboutGroupResponseBody execute(Long groupId, Long userId);
}
