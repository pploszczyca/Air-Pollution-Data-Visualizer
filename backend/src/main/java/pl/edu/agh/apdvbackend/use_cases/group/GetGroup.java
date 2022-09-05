package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.models.database.Group;

public interface GetGroup {
    Group execute(Long groupId);
}
