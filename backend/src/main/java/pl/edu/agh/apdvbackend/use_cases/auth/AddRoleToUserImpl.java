package pl.edu.agh.apdvbackend.use_cases.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.UserMapper;
import pl.edu.agh.apdvbackend.models.body_models.auth.UserWithRoles;
import pl.edu.agh.apdvbackend.models.database.Role;
import pl.edu.agh.apdvbackend.repositories.UserRepository;
import pl.edu.agh.apdvbackend.use_cases.user.GetUser;

@Component
@RequiredArgsConstructor
public class AddRoleToUserImpl implements AddRoleToUser {

    private final GetUser getUser;
    private final UserMapper userMapper;
    private final UserRepository userRepository;

    @Override
    public UserWithRoles execute(Long userId, String roleName) {
        final var role = Role.valueOf(roleName);
        final var user = getUser.execute(userId);

        user.addRole(role);
        userRepository.save(user);

        return userMapper.toUserWithRoles(user);
    }
}
