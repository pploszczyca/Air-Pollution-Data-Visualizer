package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.GroupEndpointMapper;
import pl.edu.agh.apdvbackend.mappers.GroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.EndpointGroupRequestBody;
import pl.edu.agh.apdvbackend.repositories.GroupRepositoryRepository;

@Component
@RequiredArgsConstructor
public class ChangeEnableEndpointsInGroupImpl
        implements ChangeEnableEndpointsInGroup {

    private final GroupEndpointMapper groupEndpointMapper;

    private final GetGroup getGroup;

    private final GroupRepositoryRepository
            groupRepositoryRepository;

    private final GroupMapper groupMapper;

    @Override
    public AboutGroupResponseBody execute(
            List<EndpointGroupRequestBody> endpointGroupRequestBodyList,
            Long groupId) {
        final var group = getGroup.execute(groupId);
        final var enableEndpointsList =
                groupEndpointMapper.addRequestBodyListToEnableEndpointsList(
                        endpointGroupRequestBodyList, group);

        groupRepositoryRepository.deleteAll(
                group.getGroupEndpoints());

        group.setGroupEndpoints(enableEndpointsList);
        groupRepositoryRepository.saveAll(enableEndpointsList);

        return groupMapper.groupToAboutResponseBody(group);
    }
}
