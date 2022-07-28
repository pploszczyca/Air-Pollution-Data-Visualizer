package pl.edu.agh.apdvbackend.mappers;

import java.util.Collection;
import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.EndpointGroupRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;
import pl.edu.agh.apdvbackend.models.database.GroupEndpointKey;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetEndpoint;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;

@Mapper(componentModel = "spring")
public abstract class GroupEndpointMapper {

    @Autowired
    protected GetEndpoint getEndpoint;

    @Autowired
    protected GetField getField;

    @Mapping(target = "id", source = "groupEndpoint.endpoint.id")
    @Mapping(target = "label", source = "groupEndpoint.endpoint.label")
    @Mapping(target = "endpointNumber", source = "groupEndpoint.endpoint.endpointNumber")
    public abstract GroupEndpointResponseBody endpointGroupToInfo(
            GroupEndpoint groupEndpoint);

    public abstract List<GroupEndpointResponseBody> groupEndpointsToInfos(
            List<GroupEndpoint> groupEndpoints);


    @Mapping(target = "id", expression = "java(makeGroupEndpointKey(group.getId(), endpointGroupRequestBody.endpointId()))")
    @Mapping(target = "endpoint", expression = "java(getEndpoint.execute(endpointGroupRequestBody.endpointId()))")
    @Mapping(target = "enableFields", expression = "java(endpointGroupRequestBody.fieldIds().stream().map(getField::execute).toList())")
    public abstract GroupEndpoint RequestBodyToEndpointGroup(
            EndpointGroupRequestBody endpointGroupRequestBody,
            Group group);

    protected GroupEndpointKey makeGroupEndpointKey(
            Long groupId, Long endpointId) {
        return new GroupEndpointKey(groupId, endpointId);
    }

    public List<GroupEndpoint> addRequestBodyListToEnableEndpointsList(
            List<EndpointGroupRequestBody> requestBodies,
            Group group) {
        return requestBodies
                .stream()
                .map(endpointGroupRequestBody -> RequestBodyToEndpointGroup(
                        endpointGroupRequestBody, group))
                .toList();
    }

    public GroupEndpointResponseBody mapToResponseBody(
            List<GroupEndpoint> groupEndpoints) {
        final var firstGroupEndpoint = groupEndpoints
                .stream()
                .findFirst()
                .orElseThrow();
        final var endpoint = firstGroupEndpoint.getEndpoint();

        return new GroupEndpointResponseBody(
                endpoint.getId(),
                endpoint.getLabel(),
                endpoint.getEndpointNumber(),
                makeSumOfFields(groupEndpoints),
                firstGroupEndpoint.getDetailedMeasurementDays(),
                firstGroupEndpoint.getApproximationPrecission()
        );
    }

    private List<Field> makeSumOfFields(List<GroupEndpoint> groupEndpoints) {
        return groupEndpoints
                .stream()
                .map(GroupEndpoint::getEnableFields)
                .flatMap(Collection::stream)
                .distinct()
                .toList();

    }
}
