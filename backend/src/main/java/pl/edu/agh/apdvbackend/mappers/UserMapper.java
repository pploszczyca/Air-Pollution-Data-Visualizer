package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AboutUserResponseBody;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AddUserRequestBody;
import pl.edu.agh.apdvbackend.models.User;

@Mapper(componentModel = "spring")
public abstract class UserMapper {

    @Autowired
    protected GroupMapper groupMapper;

    public abstract User addRequestBodyToUser(AddUserRequestBody addUserRequestBody);

    public abstract void updateUserFromAddRequestBody(AddUserRequestBody addUserRequestBody, @MappingTarget User user);

    @Mapping(target = "userGroups", expression = "java(user.getGroups().stream().map(groupMapper::groupToShortGroupInfo).toList())")
    public abstract AboutUserResponseBody userToAboutResponseBody(User user);

    public abstract List<AboutUserResponseBody> userListToAboutResponseBodyList(List<User> userList);
}
