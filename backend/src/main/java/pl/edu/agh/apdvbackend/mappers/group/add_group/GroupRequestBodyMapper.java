package pl.edu.agh.apdvbackend.mappers.group.add_group;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupRequestBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface GroupRequestBodyMapper {
    Group toGroup(GroupRequestBody groupRequestBody);
}
