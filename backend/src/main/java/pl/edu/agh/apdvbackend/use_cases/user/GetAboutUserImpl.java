package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AboutUserResponseBody;
import pl.edu.agh.apdvbackend.mappers.UserMapper;

@Component
@RequiredArgsConstructor
public class GetAboutUserImpl
        implements GetAboutUser {

    private final UserMapper userMapper;

    private final GetUser getUser;

    @Override
    public AboutUserResponseBody execute(Long userId) {
        return userMapper.userToAboutResponseBody(getUser.execute(userId));
    }
}
