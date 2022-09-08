package pl.edu.agh.apdvbackend.mappers.group_endpoint;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.field.IdsToFieldsMapper;
import pl.edu.agh.apdvbackend.mappers.group_endpoint_key.GroupEndpointKeyMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetEndpoint;

@Mapper(componentModel = "spring")
public abstract class GroupEndpointMapper {

    @Autowired
    protected GetEndpoint getEndpoint;

    @Autowired
    protected IdsToFieldsMapper idsToFieldsMapper;

    @Autowired
    protected GroupEndpointKeyMapper groupEndpointKeyMapper;

    public List<GroupEndpoint> toGroupEndpointList(
            List<GroupEndpointRequestBody> requestBodies,
            Group group
    ) {
        return requestBodies
                .stream()
                .map(endpointGroupRequestBody -> toEndpointGroup(endpointGroupRequestBody, group))
                .toList();
    }

    @Mapping(target = "id", expression = "java(groupEndpointKeyMapper.map(group.getId(), requestBody.endpointId()))")
    @Mapping(target = "endpoint", expression = "java(getEndpoint.execute(requestBody.endpointId()))")
    @Mapping(target = "enableFields", expression = "java(idsToFieldsMapper.toFields(requestBody.fieldIds()))")
    public abstract GroupEndpoint toEndpointGroup(
            GroupEndpointRequestBody requestBody,
            Group group
    );
}
