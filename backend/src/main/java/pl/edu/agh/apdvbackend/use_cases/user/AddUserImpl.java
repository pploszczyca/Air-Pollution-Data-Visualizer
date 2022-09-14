package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.user.UserMapper;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;
import pl.edu.agh.apdvbackend.models.database.Role;
import pl.edu.agh.apdvbackend.models.database.User;
import pl.edu.agh.apdvbackend.repositories.UserRepository;
import pl.edu.agh.apdvbackend.validators.UserDataValidationUtilities;

@Component
@RequiredArgsConstructor
public class AddUserImpl implements AddUser {

    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final UserDataValidationUtilities userDataValidationUtilities;

    @Override
    public User execute(UserRequestBody userRequestBody) {
        validateRequestBody(userRequestBody);
        final var user = userMapper.toUser(userRequestBody);
        user.addRole(Role.USER);

        return userRepository.save(user);
    }

    @SneakyThrows
    private void validateRequestBody(UserRequestBody userRequestBody) {
        userDataValidationUtilities.validateEmail(userRequestBody.email());
    }
}
