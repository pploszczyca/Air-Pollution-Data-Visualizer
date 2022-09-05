package pl.edu.agh.apdvbackend.mappers.group.admin_panel;

import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Mapper(componentModel = "spring")
public abstract class AdminPanelGroupMapper {

    @Autowired
    private AdminPanelGroupEndpointMapper endpointMapper;

    @Mapping(target = "groupId", source = "group.id")
    @Mapping(target = "groupName", source = "group.name")
    @Mapping(target = "endpoints", expression = "java(getEndpoints(group, endpoints))")
    public abstract AdminPanelGroupResponseBody toResponseBody(Group group,
                                                               List<Endpoint> endpoints);

    protected List<AdminPanelGroupResponseBody.Endpoint> getEndpoints(
            Group group, List<Endpoint> endpoints) {
        final var endpointsBelongsToGroup = group
                .getGroupEndpoints()
                .stream()
                .collect(Collectors.toMap(GroupEndpoint::getEndpoint,
                        Function.identity()));

        return endpoints
                .stream()
                .map(endpoint -> endpointMapper.toEndpoint(endpoint,
                        endpointsBelongsToGroup.get(endpoint)))
                .toList();
    }
}
