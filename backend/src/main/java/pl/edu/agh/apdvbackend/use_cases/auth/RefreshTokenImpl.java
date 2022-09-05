package pl.edu.agh.apdvbackend.use_cases.auth;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.exceptions.IncorrectAuthorizationHeaderException;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;
import pl.edu.agh.apdvbackend.use_cases.user.GetUser;
import pl.edu.agh.apdvbackend.utilities.JwtTokenUtils;
import pl.edu.agh.apdvbackend.validators.AuthorizationHeaderValidation;

import static org.springframework.http.HttpHeaders.AUTHORIZATION;

@Component
@RequiredArgsConstructor
public class RefreshTokenImpl implements RefreshToken {

    private static final String TOKEN_PREFIX = "Bearer ";
    private static final String USER_ID = "id";
    private final AuthorizationHeaderValidation authorizationHeaderValidation;
    private final Algorithm algorithm;
    private final GetUser getUser;
    private final JwtTokenUtils jwtTokenUtils;

    @SneakyThrows
    @Override
    public JWTResponse execute(HttpServletRequest request) {
        final var authorizationHeader = request.getHeader(AUTHORIZATION);
        if (!authorizationHeaderValidation.isFormatProper(
                authorizationHeader)) {
            throw new IncorrectAuthorizationHeaderException();
        }

        final var userId = parseAuthorizationHeaderAndGetUserId(authorizationHeader);
        final var user = getUser.execute(userId);

        return new JWTResponse(
                jwtTokenUtils.generateAccessToken(user),
                jwtTokenUtils.generateRefreshToken(user)
        );
    }

    private Long parseAuthorizationHeaderAndGetUserId(
            String authorizationHeader) {
        final var token = authorizationHeader.substring(TOKEN_PREFIX.length());
        final var verifier = JWT.require(algorithm).build();
        final var decodedJWT = verifier.verify(token);

        return decodedJWT.getClaim(USER_ID).asLong();
    }
}
