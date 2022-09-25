package pl.edu.agh.apdvbackend.mappers.user;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring")
public abstract class UserMapper {

    @Autowired
    protected PasswordEncoder passwordEncoder;

    @UserMapping
    public abstract User toUser(UserRequestBody userRequestBody);

    @UserMapping
    public abstract void updateUser(UserRequestBody userRequestBody, @MappingTarget User user);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "groups", ignore = true)
    @Mapping(target = "roles", ignore = true)
    @Mapping(target = "password", expression = "java(passwordEncoder.encode(userRequestBody.password()))")
    private @interface UserMapping {
    }
}
