package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.UserMapper;
import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;

@Component
@RequiredArgsConstructor
public class GetAboutUserImpl implements GetAboutUser {

    private final UserMapper userMapper;
    private final GetUser getUser;

    @Override
    public UserResponseBody execute(Long userId) {
        return userMapper.userToAboutResponseBody(getUser.execute(userId));
    }
}
