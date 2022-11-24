package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.group_endpoint.GroupEndpointMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupEndpointRequestBody;
import pl.edu.agh.apdvbackend.repositories.GroupEndpointRepository;

@Component
@RequiredArgsConstructor
public class ChangeEnableEndpointsInGroupImpl implements ChangeEnableEndpointsInGroup {

    private final GroupEndpointMapper groupEndpointMapper;
    private final GetGroup getGroup;
    private final GetAdminPanelGroup getAdminPanelGroup;
    private final GroupEndpointRepository groupEndpointRepository;

    @Override
    public AdminPanelGroupResponseBody execute(
            List<GroupEndpointRequestBody> groupEndpointRequestBodyList,
            Long groupId) {
        final var group = getGroup.execute(groupId);
        final var enableEndpointsList = groupEndpointMapper
                .toGroupEndpointList(groupEndpointRequestBodyList, group);

        groupEndpointRepository.deleteAllByGroupId(groupId);
        groupEndpointRepository.saveAll(enableEndpointsList);

        return getAdminPanelGroup.execute(groupId);
    }
}
