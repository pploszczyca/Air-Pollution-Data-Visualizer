package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.mappers.GroupMapper;
import pl.edu.agh.apdvbackend.repositories.GroupRepository;

@Component
@RequiredArgsConstructor
public class GetAboutGroupInfoImpl
        implements GetAboutGroupInfo {

    private final GroupMapper groupMapper;

    private final GroupRepository groupRepository;

    @Override
    public AboutGroupResponseBody execute(Long groupId) {
        final var group = groupRepository.findById(groupId).orElseThrow();
        return groupMapper.groupToAboutResponseBody(group);
    }
}
