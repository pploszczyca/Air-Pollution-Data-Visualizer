package pl.edu.agh.apdvbackend.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import static pl.edu.agh.apdvbackend.configs.SwaggerConfig.JWT_AUTH;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;
import pl.edu.agh.apdvbackend.services.AuthService;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@Tag(name = "Auth")
public class AuthController {

    private final AuthService authService;

    @Operation(summary = "Log in user to backend")
    @PostMapping("/login")
    public Response<JWTResponse> logInUser(
            @RequestBody LogInRequestBody logInRequestBody) {
        return authService.logInUser(logInRequestBody);
    }

    @Operation(summary = "Register new user")
    @PostMapping("/register")
    public Response<JWTResponse> registerUser(
            @RequestBody AddUserRequestBody addUserRequestBody) {
        return authService.registerUser(addUserRequestBody);
    }

    @Operation(summary = "Refresh token, when access token is expired", security = @SecurityRequirement(name = JWT_AUTH))
    @PostMapping("/refresh-token")
    public Response<JWTResponse> refreshToken(
            HttpServletRequest httpServletRequest) {
        return authService.refreshToken(httpServletRequest);
    }
}
