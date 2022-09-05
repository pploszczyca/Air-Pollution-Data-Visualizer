package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.UserMapper;
import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;
import pl.edu.agh.apdvbackend.models.database.User;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@Component
@RequiredArgsConstructor
public class UpdateUserImpl implements UpdateUser {

    private final UserRepository userRepository;
    private final UserMapper userMapper;

    @Override
    public User execute(Long userId, AddUserRequestBody addUserRequestBody) {
        final var updatingUser = userRepository
                .findById(userId)
                .orElseThrow();
        userMapper.updateUserFromAddRequestBody(addUserRequestBody, updatingUser);
        return userRepository.save(updatingUser);
    }
}
