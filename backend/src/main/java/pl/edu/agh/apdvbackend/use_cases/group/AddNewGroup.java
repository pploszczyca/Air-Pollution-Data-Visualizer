package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.controllers.group.body_models.AddGroupRequestBody;
import pl.edu.agh.apdvbackend.models.Group;

public interface AddNewGroup {
    Group execute(AddGroupRequestBody addGroupRequestBody);
}
