package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.Group;
import pl.edu.agh.apdvbackend.repositories.GroupRepository;

@Component
@RequiredArgsConstructor
public class SaveOrUpdateGroupImpl
        implements SaveOrUpdateGroup {

    private final GroupRepository groupRepository;

    @Override
    public Group execute(Group group) {
        return groupRepository.save(group);
    }
}
