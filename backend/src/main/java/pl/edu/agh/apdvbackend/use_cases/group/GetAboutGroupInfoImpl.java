package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.mappers.GroupMapper;

@Component
@RequiredArgsConstructor
public class GetAboutGroupInfoImpl
        implements GetAboutGroupInfo {

    private final GroupMapper groupMapper;

    private final GetGroup getGroup;

    @Override
    public AboutGroupResponseBody execute(Long groupId) {
        return groupMapper.groupToAboutResponseBody(getGroup.execute(groupId));
    }
}
