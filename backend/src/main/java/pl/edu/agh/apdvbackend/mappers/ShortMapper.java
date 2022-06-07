package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.controllers.group.body_models.ShortGroupInfoResponseBody;
import pl.edu.agh.apdvbackend.models.Group;

@Mapper(componentModel = "spring")
public interface ShortMapper {
    ShortGroupInfoResponseBody groupToShortGroupInfo(Group group);
}
