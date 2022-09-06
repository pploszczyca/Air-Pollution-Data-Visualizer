package pl.edu.agh.apdvbackend.mappers.group.add_group;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupRequestBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring")
public interface GroupRequestBodyMapper {
    Group toGroup(GroupRequestBody groupRequestBody);
}
