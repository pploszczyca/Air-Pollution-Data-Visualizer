package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.GroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.AddGroupRequestBody;

@Component
@RequiredArgsConstructor
public class AddNewGroupImpl
        implements AddNewGroup {

    private final SaveOrUpdateGroup saveOrUpdateGroup;

    private final GroupMapper groupMapper;

    @Override
    public AboutGroupResponseBody execute(
            AddGroupRequestBody addGroupRequestBody) {
        final var group = saveOrUpdateGroup.execute(
                groupMapper.addRequestBodyToGroup(addGroupRequestBody));
        return groupMapper.groupToAboutResponseBody(group);
    }
}
