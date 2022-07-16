package pl.edu.agh.apdvbackend.use_cases.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.RegisterRequestBody;

@Component
@RequiredArgsConstructor
public class RegisterUserImpl
        implements RegisterUser {
    @Override
    public JWTResponse execute(RegisterRequestBody registerRequestBody) {
        return null;
    }
}
