package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AboutUserResponseBody;
import pl.edu.agh.apdvbackend.mappers.UserMapper;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@Component
@RequiredArgsConstructor
public class GetAboutUserImpl
        implements GetAboutUser {

    private final UserMapper userMapper;

    private final UserRepository userRepository;

    @Override
    public AboutUserResponseBody execute(Long userId) {
        final var user = userRepository.findById(userId).orElseThrow();
        return userMapper.userToAboutResponseBody(user);
    }
}
