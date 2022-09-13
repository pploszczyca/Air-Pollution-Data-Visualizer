package pl.edu.agh.apdvbackend.mappers.group.short_group;

import java.util.List;
import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring")
public interface ShortGroupMapper {

    ShortGroupResponseBody toShortGroup(Group group);

    List<ShortGroupResponseBody> toShortGroupList(List<Group> groupList);
}
