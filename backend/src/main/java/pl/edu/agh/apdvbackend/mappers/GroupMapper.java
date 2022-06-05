package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AddGroupRequestBody;
import pl.edu.agh.apdvbackend.controllers.group.body_models.ShortGroupInfoResponseBody;
import pl.edu.agh.apdvbackend.models.Group;

@Mapper(componentModel = "spring")
public abstract class GroupMapper {

    @Autowired
    protected UserMapper userMapper;

    @Autowired
    protected EnableEndpointsForGroupMapper enableEndpointsForGroupMapper;

    public abstract ShortGroupInfoResponseBody groupToShortGroupInfo(Group group);

    public abstract List<ShortGroupInfoResponseBody> groupListToShortGroupInfoList(List<Group> groupList);

    @Mapping(target = "shortUserInfos", expression = "java(userMapper.userListToShortInfoList(group.getUsersInGroup().stream().toList()))")
    @Mapping(target = "enableEndpointInfos", expression = "java(enableEndpointsForGroupMapper.enableEndpointForGroupListToListInfo(group.getEnableEndpointsForGroups().stream().toList()))")
    public abstract AboutGroupResponseBody groupToAboutResponseBody(Group group);

    public abstract Group addRequestBodyToGroup(AddGroupRequestBody addGroupRequestBody);
}
