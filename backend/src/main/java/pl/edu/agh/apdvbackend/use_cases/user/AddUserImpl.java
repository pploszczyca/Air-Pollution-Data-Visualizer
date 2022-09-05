package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.UserMapper;
import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;
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
    public User execute(AddUserRequestBody addUserRequestBody) {
        validateRequestBody(addUserRequestBody);
        final var user = userMapper.addRequestBodyToUser(addUserRequestBody);
        user.addRole(Role.USER);

        return userRepository.save(user);
    }

    @SneakyThrows
    private void validateRequestBody(AddUserRequestBody addUserRequestBody) {
        userDataValidationUtilities.validateEmail(addUserRequestBody.email());
    }
}
