package pl.edu.agh.apdvbackend.mappers;

import java.util.Collection;
import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.AboutUserResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserInfo;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring")
public abstract class UserMapper {

    @Autowired
    protected ShortMapper shortMapper;

    @Autowired
    protected PasswordEncoder passwordEncoder;

    @Mapping(target = "password", expression = "java(passwordEncoder.encode(addUserRequestBody.password()))")
    public abstract User addRequestBodyToUser(
            AddUserRequestBody addUserRequestBody);

    public abstract void updateUserFromAddRequestBody(
            AddUserRequestBody addUserRequestBody, @MappingTarget User user);

    @Mapping(target = "userGroups", expression = "java(user.getGroups().stream().map(shortMapper::groupToShortGroupInfo).toList())")
    public abstract AboutUserResponseBody userToAboutResponseBody(User user);

    public abstract List<AboutUserResponseBody> userListToAboutResponseBodyList(
            List<User> userList);

    public abstract ShortUserInfo userToShortInfo(User user);

    public abstract List<ShortUserInfo> userListToShortInfoList(
            List<User> userList);

    public abstract LogInRequestBody addUserToLogIn(AddUserRequestBody addUserRequestBody);

    public org.springframework.security.core.userdetails.User userToUserDetails(User user) {
        return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(), getUserAuthorities(user));
    }

    private Collection<SimpleGrantedAuthority> getUserAuthorities(User user) {
        return user
                .getRoles()
                .stream()
                .map(role -> new SimpleGrantedAuthority(role.name()))
                .toList();
    }
}
