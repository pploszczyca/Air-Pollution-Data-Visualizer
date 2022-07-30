package pl.edu.agh.apdvbackend.mappers.group.admin_panel;

import java.util.ArrayList;
import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Mapper(componentModel = "spring")
public abstract class AdminPanelGroupEndpointMapper {

    @Autowired
    private AdminPanelGroupFieldMapper fieldMapper;

    @Mapping(target = "id", source = "endpoint.id")
    @Mapping(target = "fields", expression = "java(getFields(endpoint, groupEndpoint))")
    public abstract AdminPanelGroupResponseBody.Endpoint toEndpoint(
            Endpoint endpoint, GroupEndpoint groupEndpoint);

    protected List<AdminPanelGroupResponseBody.Endpoint.Field> getFields(
            Endpoint endpoint,
            GroupEndpoint groupEndpoint) {
        final var fields = endpoint
                .getFieldParserMap()
                .keySet()
                .stream()
                .toList();

        final var enableFields = groupEndpoint == null
                ? new ArrayList<Field>()
                : groupEndpoint.getEnableFields();

        return fieldMapper.toFieldList(fields, enableFields);
    }
}
