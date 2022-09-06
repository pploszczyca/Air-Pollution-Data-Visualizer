package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.group.about_group.AboutGroupMapper;
import pl.edu.agh.apdvbackend.mappers.group.add_group.GroupRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupRequestBody;

@Component
@RequiredArgsConstructor
public class AddNewGroupImpl implements AddNewGroup {

    private final SaveOrUpdateGroup saveOrUpdateGroup;
    private final AboutGroupMapper aboutGroupMapper;
    private final GroupRequestBodyMapper requestBodyMapper;

    @Override
    public AboutGroupResponseBody execute(GroupRequestBody groupRequestBody) {
        final var group = saveOrUpdateGroup.execute(
                requestBodyMapper.toGroup(groupRequestBody)
        );
        return aboutGroupMapper.toAboutGroupResponseBody(group);
    }
}
