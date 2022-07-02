package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.EnableEndpointsForGroupMapper;
import pl.edu.agh.apdvbackend.mappers.GroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.AddEnableEndpointRequestBody;
import pl.edu.agh.apdvbackend.repositories.EnableEndpointsForGroupRepository;

@Component
@RequiredArgsConstructor
public class ChangeEnableEndpointsInGroupImpl
        implements ChangeEnableEndpointsInGroup {

    private final EnableEndpointsForGroupMapper enableEndpointsForGroupMapper;

    private final GetGroup getGroup;

    private final EnableEndpointsForGroupRepository
            enableEndpointsForGroupRepository;

    private final GroupMapper groupMapper;

    @Override
    public AboutGroupResponseBody execute(
            List<AddEnableEndpointRequestBody> addEnableEndpointRequestBodyList,
            Long groupId) {
        final var group = getGroup.execute(groupId);
        final var enableEndpointsList =
                enableEndpointsForGroupMapper.addRequestBodyListToEnableEndpointsList(
                        addEnableEndpointRequestBodyList, group);

        enableEndpointsForGroupRepository.deleteAll(
                group.getEnableEndpointsForGroups());

        group.setEnableEndpointsForGroups(enableEndpointsList);
        enableEndpointsForGroupRepository.saveAll(enableEndpointsList);

        return groupMapper.groupToAboutResponseBody(group);
    }
}
