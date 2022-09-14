package pl.edu.agh.apdvbackend.mappers.group.about_group;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.group_endpoint.GroupEndpointResponseBodyMapper;
import pl.edu.agh.apdvbackend.mappers.user.ShortUserResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Group;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public abstract class AboutGroupMapper {

    @Autowired
    protected ShortUserResponseBodyMapper shortUserMapper;

    @Autowired
    protected GroupEndpointResponseBodyMapper groupEndpointResponseBodyMapper;

    @Mapping(
            target = "shortUserInfos",
            expression = "java(shortUserMapper.mapToList(group.getUsersInGroup().stream().toList()))"
    )
    @Mapping(
            target = "groupEndpointResponseBodies",
            expression = "java(groupEndpointResponseBodyMapper.toResponseBodyList(" +
                    "group.getGroupEndpoints().stream().toList()))"
    )
    public abstract AboutGroupResponseBody toAboutGroupResponseBody(Group group);
}
