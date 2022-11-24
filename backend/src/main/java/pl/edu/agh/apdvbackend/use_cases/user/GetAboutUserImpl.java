package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.user.UserResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;

@Component
@RequiredArgsConstructor
public class GetAboutUserImpl implements GetAboutUser {

    private final UserResponseBodyMapper mapper;
    private final GetUser getUser;

    @Override
    public UserResponseBody execute(Long userId) {
        return mapper.toUserResponseBody(getUser.execute(userId));
    }
}
