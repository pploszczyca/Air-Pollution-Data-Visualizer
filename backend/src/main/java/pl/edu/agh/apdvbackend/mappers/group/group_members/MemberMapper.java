package pl.edu.agh.apdvbackend.mappers.group.group_members;

import java.util.List;
import java.util.Set;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupMembersResponseBody;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring")
public abstract class MemberMapper {

    @Autowired
    protected MemberGroupNamesMapper groupNamesMapper;

    public List<GroupMembersResponseBody.Member> toMemberList(Set<User> users, Long groupId) {
        return users
                .stream()
                .map(user -> toMember(user, groupId))
                .toList();
    }

    @Mapping(
            target = "otherGroupNames",
            expression = "java(groupNamesMapper.toOtherGroupNames(user.getGroups(), groupId))"
    )
    public abstract GroupMembersResponseBody.Member toMember(User user, Long groupId);
}
