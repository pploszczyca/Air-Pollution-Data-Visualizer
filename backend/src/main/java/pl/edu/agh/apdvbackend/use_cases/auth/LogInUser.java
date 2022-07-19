package pl.edu.agh.apdvbackend.use_cases.auth;

import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;

public interface LogInUser {
    JWTResponse execute(LogInRequestBody logInRequestBody);
}
