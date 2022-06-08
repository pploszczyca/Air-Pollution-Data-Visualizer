package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.Group;
import pl.edu.agh.apdvbackend.repositories.GroupRepository;

@Component
@RequiredArgsConstructor
public class GetGroupImpl
        implements GetGroup {

    private final GroupRepository groupRepository;

    @Override
    public Group execute(Long groupId) {
        return groupRepository.findById(groupId).orElseThrow();
    }
}
