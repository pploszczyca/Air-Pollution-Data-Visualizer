package pl.edu.agh.apdvbackend.mappers.user;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.group.short_group.ShortGroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public abstract class UserResponseBodyMapper {

    @Autowired
    private ShortGroupMapper shortGroupMapper;

    @Mapping(
            target = "groups",
            expression = "java(mapUsersGroupsToShortGroups(user))"
    )
    public abstract UserResponseBody map(User user);

    public abstract List<UserResponseBody> mapToList(List<User> users);

    protected List<ShortGroupResponseBody> mapUsersGroupsToShortGroups(User user) {
        return user
                .getGroups()
                .stream()
                .map(shortGroupMapper::toShortGroup)
                .toList();
    }
}
