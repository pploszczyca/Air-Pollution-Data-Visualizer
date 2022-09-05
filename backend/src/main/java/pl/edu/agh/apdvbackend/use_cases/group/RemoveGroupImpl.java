package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.GroupRepository;

@Component
@RequiredArgsConstructor
public class RemoveGroupImpl implements RemoveGroup {

    private final GroupRepository groupRepository;

    @Override
    public void execute(Long groupId) {
        groupRepository.deleteById(groupId);
    }
}
