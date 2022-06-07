package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AddEnableEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.EnableEndpointsForGroup;
import pl.edu.agh.apdvbackend.models.EnableEndpointsForGroupKey;
import pl.edu.agh.apdvbackend.models.Group;
import pl.edu.agh.apdvbackend.models.body_models.EnableEndpointInfo;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetEndpoint;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;

@Mapper(componentModel = "spring")
public abstract class EnableEndpointsForGroupMapper {

    @Autowired
    protected GetEndpoint getEndpoint;

    @Autowired
    protected GetField getField;

    @Mapping(target = "id", source = "enableEndpointsForGroup.endpoint.id")
    @Mapping(target = "label", source = "enableEndpointsForGroup.endpoint.label")
    @Mapping(target = "endpointNumber", source = "enableEndpointsForGroup.endpoint.endpointNumber")
    public abstract EnableEndpointInfo enableEndpointForGroupToInfo(
            EnableEndpointsForGroup enableEndpointsForGroup);

    public abstract List<EnableEndpointInfo> enableEndpointForGroupListToListInfo(
            List<EnableEndpointsForGroup> enableEndpointsForGroupList);


    @Mapping(target = "id", expression = "java(makeEnableEndpointsForGroupKey(group.getId(), addEnableEndpointRequestBody.endpointId()))")
    @Mapping(target = "endpoint", expression = "java(getEndpoint.execute(addEnableEndpointRequestBody.endpointId()))")
    @Mapping(target = "enableFields", expression = "java(addEnableEndpointRequestBody.fieldIds().stream().map(getField::execute).toList())")
    public abstract EnableEndpointsForGroup addRequestBodyToEnableEndpoints(
            AddEnableEndpointRequestBody addEnableEndpointRequestBody,
            Group group);

    protected EnableEndpointsForGroupKey makeEnableEndpointsForGroupKey(
            Long groupId, Long endpointId) {
        return new EnableEndpointsForGroupKey(groupId, endpointId);
    }

    public List<EnableEndpointsForGroup> addRequestBodyListToEnableEndpointsList(
            List<AddEnableEndpointRequestBody> addEnableEndpointRequestBodyList,
            Group group) {
        return addEnableEndpointRequestBodyList
                .stream()
                .map(addEnableEndpointRequestBody -> addRequestBodyToEnableEndpoints(
                        addEnableEndpointRequestBody, group))
                .toList();
    }
}
