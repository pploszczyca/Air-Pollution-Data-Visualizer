package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.GroupEndpointRepository;
import pl.edu.agh.apdvbackend.repositories.GroupRepository;

@Component
@RequiredArgsConstructor
public class RemoveGroupImpl
        implements RemoveGroup {

    private final GroupRepository groupRepository;

    private final GroupEndpointRepository groupEndpointRepository;

    @Override
    public void execute(Long groupId) {
        groupEndpointRepository.deleteAllByGroupId(groupId);
        groupRepository.deleteById(groupId);
    }
}
