package pl.edu.agh.apdvbackend.mappers.group.group_members;

import java.util.List;
import java.util.Objects;
import java.util.Set;
import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring")
public abstract class MemberGroupNamesMapper {
    public List<String> toOtherGroupNames(Set<Group> userGroups, Long groupId) {
        return userGroups
                .stream()
                .filter(group -> !Objects.equals(group.getId(), groupId))
                .map(Group::getName)
                .sorted()
                .toList();
    }
}
