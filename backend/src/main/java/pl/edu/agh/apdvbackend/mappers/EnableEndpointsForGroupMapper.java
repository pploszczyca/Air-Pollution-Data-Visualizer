package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import pl.edu.agh.apdvbackend.models.EnableEndpointsForGroup;
import pl.edu.agh.apdvbackend.models.body_models.EnableEndpointInfo;

@Mapper(componentModel = "spring")
public interface EnableEndpointsForGroupMapper {
    @Mapping(target = "id", source = "enableEndpointsForGroup.endpoint.id")
    @Mapping(target = "label", source = "enableEndpointsForGroup.endpoint.label")
    @Mapping(target = "endpointNumber", source = "enableEndpointsForGroup.endpoint.endpointNumber")
    EnableEndpointInfo enableEndpointForGroupToInfo(
            EnableEndpointsForGroup enableEndpointsForGroup);

    List<EnableEndpointInfo> enableEndpointForGroupListToListInfo(List<EnableEndpointsForGroup> enableEndpointsForGroupList);
}
