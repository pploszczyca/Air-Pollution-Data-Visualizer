package pl.edu.agh.apdvbackend.use_cases.group;

import pl.edu.agh.apdvbackend.models.database.Group;

public interface SaveOrUpdateGroup {
    Group execute(Group group);
}
