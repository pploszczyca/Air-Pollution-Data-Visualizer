package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import pl.edu.agh.apdvbackend.mappers.group.short_group.ShortGroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring")
public abstract class UserMapper {

    @Autowired
    protected ShortGroupMapper shortGroupMapper;

    @Autowired
    protected PasswordEncoder passwordEncoder;

    @Mapping(target = "password", expression = "java(passwordEncoder.encode(userRequestBody.password()))")
    public abstract User addRequestBodyToUser(
            UserRequestBody userRequestBody);

    @Mapping(target = "password", expression = "java(passwordEncoder.encode(userRequestBody.password()))")
    public abstract void updateUserFromAddRequestBody(
            UserRequestBody userRequestBody, @MappingTarget User user);

    @Mapping(
            target = "groups",
            expression = "java(user.getGroups().stream().map(shortGroupMapper::toShortGroup).toList())"
    )
    public abstract UserResponseBody userToAboutResponseBody(User user);

    public abstract List<UserResponseBody> userListToAboutResponseBodyList(
            List<User> userList);

    public abstract ShortUserResponseBody toShortResponseBody(User user);

    public abstract List<ShortUserResponseBody> toShortResponseBodyList(
            List<User> users);
}
