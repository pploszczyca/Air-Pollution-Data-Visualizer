package pl.edu.agh.apdvbackend.use_cases.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.repositories.UserRepository;
import pl.edu.agh.apdvbackend.utilities.JwtTokenUtils;

@Component
@RequiredArgsConstructor
public class LogInUserImpl
        implements LogInUser {

    private final AuthenticationManager authenticationManager;

    private final UserRepository userRepository;

    private final JwtTokenUtils jwtTokenUtils;

    @Override
    public JWTResponse execute(LogInRequestBody logInRequestBody) {
        final var authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        logInRequestBody.email(),
                        logInRequestBody.password()));

        final var securityUser =
                (org.springframework.security.core.userdetails.User) authentication.getPrincipal();
        final var user =
                userRepository.findByEmail(securityUser.getUsername())
                        .orElseThrow();

        return new JWTResponse(
                jwtTokenUtils.generateAccessToken(user),
                jwtTokenUtils.generateRefreshToken(user)
        );
    }
}
