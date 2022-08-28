package pl.edu.agh.apdvbackend.mappers.group.add_group;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AddGroupRequestBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring")
public interface AddGroupRequestBodyMapper {
    Group toGroup(AddGroupRequestBody addGroupRequestBody);
}
