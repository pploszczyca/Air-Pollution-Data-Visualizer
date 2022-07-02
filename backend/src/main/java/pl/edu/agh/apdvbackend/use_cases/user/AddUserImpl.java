package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.UserMapper;
import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;
import pl.edu.agh.apdvbackend.models.database.User;
import pl.edu.agh.apdvbackend.repositories.UserRepository;
import pl.edu.agh.apdvbackend.use_cases.validation.ValidateAddUserRequestBody;

@Component
@RequiredArgsConstructor
public class AddUserImpl
        implements AddUser {

    private final UserRepository userRepository;

    private final UserMapper userMapper;

    private final ValidateAddUserRequestBody validateAddUserRequestBody;

    @SneakyThrows
    @Override
    public User execute(AddUserRequestBody addUserRequestBody) {
        validateAddUserRequestBody.execute(addUserRequestBody);

        return userRepository.save(
                userMapper.addRequestBodyToUser(addUserRequestBody));
    }
}
