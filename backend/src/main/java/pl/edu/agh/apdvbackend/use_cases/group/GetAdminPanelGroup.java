package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;

public interface GetAdminPanelGroup {
    AdminPanelGroupResponseBody execute(Long groupId);
}
