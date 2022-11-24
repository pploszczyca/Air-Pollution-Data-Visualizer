package pl.edu.agh.apdvbackend.services;

import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;
import pl.edu.agh.apdvbackend.use_cases.auth.LogInUser;
import pl.edu.agh.apdvbackend.use_cases.auth.RefreshToken;
import pl.edu.agh.apdvbackend.use_cases.auth.RegisterUser;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final LogInUser logInUser;
    private final RegisterUser registerUser;
    private final RefreshToken refreshToken;

    public Response<JWTResponse> logInUser(LogInRequestBody logInRequestBody) {
        return Response.withOkStatus(logInUser.execute(logInRequestBody));
    }

    public Response<JWTResponse> registerUser(UserRequestBody userRequestBody) {
        return Response.withOkStatus(registerUser.execute(userRequestBody));
    }

    public Response<JWTResponse> refreshToken(HttpServletRequest httpServletRequest) {
        return Response.withOkStatus(refreshToken.execute(httpServletRequest));
    }
}
