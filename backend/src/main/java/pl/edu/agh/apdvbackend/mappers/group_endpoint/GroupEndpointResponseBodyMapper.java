package pl.edu.agh.apdvbackend.mappers.group_endpoint;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface GroupEndpointResponseBodyMapper {

    @Mapping(target = "id", source = "groupEndpoint.endpoint.id")
    @Mapping(target = "label", source = "groupEndpoint.endpoint.label")
    @Mapping(target = "endpointNumber", source = "groupEndpoint.endpoint.endpointNumber")
    GroupEndpointResponseBody toResponseBody(GroupEndpoint groupEndpoint);

    List<GroupEndpointResponseBody> toResponseBodyList(List<GroupEndpoint> groupEndpoints);
}
