package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.GroupMapper;
import pl.edu.agh.apdvbackend.mappers.group.add_group.AddGroupRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.AddGroupRequestBody;

@Component
@RequiredArgsConstructor
public class AddNewGroupImpl implements AddNewGroup {

    private final SaveOrUpdateGroup saveOrUpdateGroup;
    private final GroupMapper groupMapper;
    private final AddGroupRequestBodyMapper requestBodyMapper;

    @Override
    public AboutGroupResponseBody execute(AddGroupRequestBody addGroupRequestBody) {
        final var group = saveOrUpdateGroup.execute(
                requestBodyMapper.toGroup(addGroupRequestBody)
        );
        return groupMapper.groupToAboutResponseBody(group);
    }
}
