package pl.edu.agh.apdvbackend.use_cases.group;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.group.admin_panel.AdminPanelGroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAdminPanelGroupImpl implements GetAdminPanelGroup {

    private final GetGroup getGroup;
    private final EndpointRepository endpointRepository;
    private final AdminPanelGroupMapper adminPanelGroupMapper;
    private final ListUtilities listUtilities;

    @Override
    public AdminPanelGroupResponseBody execute(Long groupId) {
        final var group = getGroup.execute(groupId);
        final var endpoints = listUtilities.iterableToList(endpointRepository.findAll());

        return adminPanelGroupMapper.toResponseBody(group, endpoints);
    }
}
