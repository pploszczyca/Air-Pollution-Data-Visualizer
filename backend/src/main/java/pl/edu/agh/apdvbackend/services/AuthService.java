package pl.edu.agh.apdvbackend.services;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.auth.RegisterRequestBody;
import pl.edu.agh.apdvbackend.use_cases.auth.LogInUser;
import pl.edu.agh.apdvbackend.use_cases.auth.RegisterUser;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final LogInUser logInUser;

    private final RegisterUser registerUser;

    public Response<JWTResponse> logInUser(LogInRequestBody logInRequestBody) {
        return Response.withOkStatus(logInUser.execute(logInRequestBody));
    }

    public Response<JWTResponse> registerUser(RegisterRequestBody registerRequestBody) {
        return Response.withOkStatus(registerUser.execute(registerRequestBody));
    }
}
