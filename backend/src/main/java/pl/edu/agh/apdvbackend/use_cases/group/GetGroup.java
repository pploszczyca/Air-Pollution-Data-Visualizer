package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.models.Group;

public interface GetGroup {
    Group execute(Long groupId);
}
