package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.mappers.GroupMapper;
import pl.edu.agh.apdvbackend.use_cases.user.GetUser;

@Component
@RequiredArgsConstructor
public class AddUserToGroupImpl
        implements AddUserToGroup {

    private final GetGroup getGroup;

    private final GetUser getUser;

    private final SaveOrUpdateGroup saveOrUpdateGroup;

    private final GroupMapper groupMapper;

    @Override
    public AboutGroupResponseBody execute(Long groupId, Long userId) {
        final var group = getGroup.execute(groupId);
        final var user = getUser.execute(userId);

        group.addUser(user);

        return groupMapper.groupToAboutResponseBody(
                saveOrUpdateGroup.execute(group));
    }
}
