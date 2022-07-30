package pl.edu.agh.apdvbackend.mappers.group.admin_panel;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Field;

@Mapper(componentModel = "spring")
public abstract class AdminPanelGroupFieldMapper {

    public List<AdminPanelGroupResponseBody.Endpoint.Field> toFieldList(
            List<Field> fields,
            List<Field> enableFields) {
        return fields
                .stream()
                .map(field -> toField(field, enableFields))
                .toList();
    }

    @Mapping(target = "unitName", source = "field.unit.name")
    @Mapping(target = "isBelongingToGroup", expression = "java(isFieldBelongsToGroup(field, enableFields))")
    public abstract AdminPanelGroupResponseBody.Endpoint.Field toField(
            Field field, List<Field> enableFields);

    protected boolean isFieldBelongsToGroup(Field field,
                                            List<Field> enableFields) {
        return enableFields.contains(field);
    }
}
