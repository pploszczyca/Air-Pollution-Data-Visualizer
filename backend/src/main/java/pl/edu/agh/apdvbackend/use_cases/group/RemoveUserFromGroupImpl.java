package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.group.about_group.AboutGroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.use_cases.user.GetUser;

@Component
@RequiredArgsConstructor
public class RemoveUserFromGroupImpl implements RemoveUserFromGroup {

    private final GetGroup getGroup;
    private final GetUser getUser;
    private final SaveOrUpdateGroup saveOrUpdateGroup;
    private final AboutGroupMapper aboutGroupMapper;

    @Override
    public AboutGroupResponseBody execute(Long groupId, Long userId) {
        final var group = getGroup.execute(groupId);
        final var user = getUser.execute(userId);

        group.removeUser(user);

        return aboutGroupMapper.toAboutGroupResponseBody(saveOrUpdateGroup.execute(group));
    }
}
