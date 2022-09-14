package pl.edu.agh.apdvbackend.use_cases.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.user.LogInRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;
import pl.edu.agh.apdvbackend.use_cases.user.AddUser;

@Component
@RequiredArgsConstructor
public class RegisterUserImpl implements RegisterUser {

    private final AddUser addUser;
    private final LogInUser logInUser;
    private final LogInRequestBodyMapper mapper;

    @Override
    public JWTResponse execute(UserRequestBody userRequestBody) {
        addUser.execute(userRequestBody);
        return logInUser.execute(mapper.toLogInRequestBody(userRequestBody));
    }
}
