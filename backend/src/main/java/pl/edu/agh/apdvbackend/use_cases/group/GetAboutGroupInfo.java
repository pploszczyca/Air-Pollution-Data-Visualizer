package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;

public interface GetAboutGroupInfo {
    AboutGroupResponseBody execute(Long groupId);
}
