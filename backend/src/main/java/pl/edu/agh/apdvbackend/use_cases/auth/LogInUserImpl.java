package pl.edu.agh.apdvbackend.use_cases.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;

@Component
@RequiredArgsConstructor
public class LogInUserImpl
        implements LogInUser {
    @Override
    public JWTResponse execute(LogInRequestBody logInRequestBody) {
        return null;
    }
}
