package pl.edu.agh.apdvbackend.mappers.group.group_members;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupMembersResponseBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public abstract class GroupMembersMapper {

    @Autowired
    protected MemberMapper memberMapper;

    @Mapping(target = "groupId", source = "id")
    @Mapping(target = "groupName", source = "name")
    @Mapping(target = "members", expression = "java(memberMapper.toMemberList(group.getUsersInGroup(), group.getId()))")
    public abstract GroupMembersResponseBody map(Group group);
}
