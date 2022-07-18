package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.AddGroupRequestBody;

public interface AddNewGroup {
    AboutGroupResponseBody execute(AddGroupRequestBody addGroupRequestBody);
}
