package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.group.GroupMembersMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupMembersResponseBody;

@Component
@RequiredArgsConstructor
public class GetGroupMembersImpl
        implements GetGroupMembers {

    private final GetGroup getGroup;

    private final GroupMembersMapper groupMembersMapper;

    @Override
    public GroupMembersResponseBody execute(Long groupId) {
        final var group = getGroup.execute(groupId);

        return groupMembersMapper.map(group);
    }
}
