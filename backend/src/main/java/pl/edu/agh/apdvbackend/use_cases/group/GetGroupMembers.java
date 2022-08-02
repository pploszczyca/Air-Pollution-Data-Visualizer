package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.models.body_models.group.GroupMembersResponseBody;

public interface GetGroupMembers {
    GroupMembersResponseBody execute(Long groupId);
}
