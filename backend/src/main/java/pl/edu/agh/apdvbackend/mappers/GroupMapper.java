package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.Group;
import pl.edu.agh.apdvbackend.models.body_models.ShortGroupInfo;

@Mapper(componentModel = "spring")
public interface GroupMapper {
    ShortGroupInfo groupToShortGroupInfo(Group group);
}
