package pl.edu.agh.apdvbackend.use_cases.auth;

import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;

public interface RegisterUser {
    JWTResponse execute(UserRequestBody userRequestBody);
}
