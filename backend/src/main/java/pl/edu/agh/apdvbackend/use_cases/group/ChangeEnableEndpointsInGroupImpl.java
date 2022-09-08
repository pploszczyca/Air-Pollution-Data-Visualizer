package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.group_endpoint.GroupEndpointMapper;
import pl.edu.agh.apdvbackend.mappers.group.about_group.AboutGroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.EndpointGroupRequestBody;
import pl.edu.agh.apdvbackend.repositories.GroupEndpointRepository;

@Component
@RequiredArgsConstructor
public class ChangeEnableEndpointsInGroupImpl implements ChangeEnableEndpointsInGroup {

    private final GroupEndpointMapper groupEndpointMapper;
    private final GetGroup getGroup;
    private final GroupEndpointRepository groupEndpointRepository;
    private final AboutGroupMapper aboutGroupMapper;

    @Override
    public AboutGroupResponseBody execute(
            List<EndpointGroupRequestBody> endpointGroupRequestBodyList,
            Long groupId) {
        final var group = getGroup.execute(groupId);
        final var enableEndpointsList = groupEndpointMapper
                .toGroupEndpointList(endpointGroupRequestBodyList, group);

        groupEndpointRepository.deleteAll(group.getGroupEndpoints());

        group.setGroupEndpoints(enableEndpointsList);
        groupEndpointRepository.saveAll(enableEndpointsList);

        return aboutGroupMapper.toAboutGroupResponseBody(group);
    }
}
