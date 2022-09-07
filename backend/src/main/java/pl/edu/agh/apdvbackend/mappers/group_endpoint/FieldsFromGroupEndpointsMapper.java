package pl.edu.agh.apdvbackend.mappers.group_endpoint;

import java.util.Collection;
import java.util.List;
import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Mapper(componentModel = "spring")
public abstract class FieldsFromGroupEndpointsMapper {
    public List<Field> map(List<GroupEndpoint> groupEndpoints) {
        return groupEndpoints
                .stream()
                .map(GroupEndpoint::getEnableFields)
                .flatMap(Collection::stream)
                .distinct()
                .toList();

    }
}
