package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AddGroupRequestBody;
import pl.edu.agh.apdvbackend.mappers.GroupMapper;
import pl.edu.agh.apdvbackend.models.Group;

@Component
@RequiredArgsConstructor
public class AddNewGroupImpl
        implements AddNewGroup {

    private final SaveOrUpdateGroup saveOrUpdateGroup;

    private final GroupMapper groupMapper;

    @Override
    public Group execute(AddGroupRequestBody addGroupRequestBody) {
        return saveOrUpdateGroup.execute(groupMapper.addRequestBodyToGroup(addGroupRequestBody));
    }
}
