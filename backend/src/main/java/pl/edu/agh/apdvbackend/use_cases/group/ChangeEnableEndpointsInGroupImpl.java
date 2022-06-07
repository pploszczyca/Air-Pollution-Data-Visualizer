package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AddEnableEndpointRequestBody;
import pl.edu.agh.apdvbackend.mappers.EnableEndpointsForGroupMapper;
import pl.edu.agh.apdvbackend.models.Group;
import pl.edu.agh.apdvbackend.repositories.EnableEndpointsForGroupRepository;

@Component
@RequiredArgsConstructor
public class ChangeEnableEndpointsInGroupImpl
        implements ChangeEnableEndpointsInGroup {

    private final EnableEndpointsForGroupMapper enableEndpointsForGroupMapper;

    private final GetGroup getGroup;

    private final EnableEndpointsForGroupRepository
            enableEndpointsForGroupRepository;

    @Override
    public Group execute(
            List<AddEnableEndpointRequestBody> addEnableEndpointRequestBodyList,
            Long groupId) {
        final var group = getGroup.execute(groupId);
        final var enableEndpointsList =
                enableEndpointsForGroupMapper.addRequestBodyListToEnableEndpointsList(
                        addEnableEndpointRequestBodyList, group);

        group.setEnableEndpointsForGroups(enableEndpointsList);
        enableEndpointsForGroupRepository.saveAll(enableEndpointsList);

        return group;
    }
}
