package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.AddGroupRequestBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring")
public abstract class GroupMapper {

    @Autowired
    protected UserMapper userMapper;

    @Autowired
    protected GroupEndpointMapper groupEndpointMapper;

    @Mapping(
            target = "shortUserInfos",
            expression = "java(userMapper.toShortResponseBodyList(group.getUsersInGroup().stream().toList()))"
    )
    @Mapping(
            target = "groupEndpointResponseBodies",
            expression = "java(groupEndpointMapper.groupEndpointsToInfos(group.getGroupEndpoints().stream().toList()))"
    )
    public abstract AboutGroupResponseBody groupToAboutResponseBody(
            Group group);

    public abstract Group addRequestBodyToGroup(
            AddGroupRequestBody addGroupRequestBody);
}
