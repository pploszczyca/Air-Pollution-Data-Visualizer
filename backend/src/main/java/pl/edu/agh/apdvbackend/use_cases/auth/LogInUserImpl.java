package pl.edu.agh.apdvbackend.use_cases.auth;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;

@Component
@RequiredArgsConstructor
public class LogInUserImpl
        implements LogInUser {

    private static final int ACCESS_TOKEN_EXPIRES_TIME = 10 * 60 * 1000;

    private static final int REFRESH_TOKEN_EXPIRES_TIME = 30 * 60 * 1000;

    private final AuthenticationManager authenticationManager;

    private final Algorithm algorithm;

    @Override
    public JWTResponse execute(LogInRequestBody logInRequestBody) {
        try {
            final var authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(logInRequestBody.email(), logInRequestBody.password()));

            final var user = (User) authentication.getPrincipal();

            return new JWTResponse(
                    makeToken(ACCESS_TOKEN_EXPIRES_TIME, user),
                    makeToken(REFRESH_TOKEN_EXPIRES_TIME, user)
            );

        } catch (BadCredentialsException badCredentialsException) {
            badCredentialsException.printStackTrace();
        }

        return null;
    }

    private String makeToken(int expireTime, User user) {
        return JWT.create()
                .withSubject(user.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() +
                        expireTime))
                .withClaim("id", user.getUsername())
                .sign(algorithm);
    }
}
