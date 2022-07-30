package pl.edu.agh.apdvbackend.mappers.group;

import java.util.List;
import java.util.Objects;
import java.util.Set;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupMembersResponseBody;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring")
public abstract class GroupMemberMapper {

    public List<GroupMembersResponseBody.Member> toMemberList(Set<User> users, Long groupId) {
        return users
                .stream()
                .map(user -> toMember(user, groupId))
                .toList();
    }

    @Mapping(target = "otherGroupNames", expression = "java(mapOtherGroupNames(user.getGroups(), groupId))")
    public abstract GroupMembersResponseBody.Member toMember(User user, Long groupId);

    protected List<String> mapOtherGroupNames(Set<Group> userGroups, Long groupId) {
        return userGroups
                .stream()
                .filter(group -> !Objects.equals(group.getId(), groupId))
                .map(Group::getName)
                .toList();
    }
}
