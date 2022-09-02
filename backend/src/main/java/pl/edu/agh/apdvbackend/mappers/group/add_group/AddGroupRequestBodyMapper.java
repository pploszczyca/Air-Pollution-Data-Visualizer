package pl.edu.agh.apdvbackend.mappers.group.add_group;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import pl.edu.agh.apdvbackend.models.body_models.group.AddGroupRequestBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AddGroupRequestBodyMapper {
    Group toGroup(AddGroupRequestBody addGroupRequestBody);
}
