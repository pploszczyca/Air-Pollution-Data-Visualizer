package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AddUserRequestBody;
import pl.edu.agh.apdvbackend.mappers.UserMapper;
import pl.edu.agh.apdvbackend.models.User;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@Component
@RequiredArgsConstructor
public class AddUserImpl
        implements AddUser {

    private final UserRepository userRepository;

    private final UserMapper userMapper;

    @Override
    public User execute(AddUserRequestBody addUserRequestBody) {
        return userRepository.save(
                userMapper.addRequestBodyToUser(addUserRequestBody));
    }
}
