package pl.edu.agh.apdvbackend.controllers;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.auth.RegisterRequestBody;
import pl.edu.agh.apdvbackend.services.AuthService;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@Tag(name = "Auth")
public class AuthController {

    private final AuthService authService;

    @PostMapping
    @RequestMapping("/login")
    public Response<JWTResponse> logInUser(
            @RequestBody LogInRequestBody logInRequestBody) {
        return authService.logInUser(logInRequestBody);
    }

    @PostMapping
    @RequestMapping("/register")
    public Response<JWTResponse> registerUser(
            @RequestBody RegisterRequestBody registerRequestBody) {
        return authService.registerUser(registerRequestBody);
    }
}
