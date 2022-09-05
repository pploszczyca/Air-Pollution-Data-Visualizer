package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring")
public interface ShortMapper {
    ShortGroupResponseBody groupToShortGroupInfo(Group group);
}
