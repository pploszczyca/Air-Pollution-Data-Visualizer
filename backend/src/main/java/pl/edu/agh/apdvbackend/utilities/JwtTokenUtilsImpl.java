package pl.edu.agh.apdvbackend.utilities;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import java.util.Date;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.Role;
import pl.edu.agh.apdvbackend.models.database.User;

@Component
@RequiredArgsConstructor
public class JwtTokenUtilsImpl implements JwtTokenUtils {

    private static final int ACCESS_TOKEN_EXPIRES_TIME = 10 * 60 * 60 * 1000;

    private static final int REFRESH_TOKEN_EXPIRES_TIME = 72 * 60 * 60 * 1000;

    private final Algorithm algorithm;

    @Override
    public String generateAccessToken(final User user) {
        return makeToken(ACCESS_TOKEN_EXPIRES_TIME, user);
    }

    @Override
    public String generateRefreshToken(final User user) {
        return makeToken(REFRESH_TOKEN_EXPIRES_TIME, user);
    }

    private String makeToken(int expireTime, User user) {
        return JWT.create()
                .withSubject(user.getEmail())
                .withExpiresAt(new Date(System.currentTimeMillis() +
                        expireTime))
                .withClaim("id", user.getId())
                .withClaim("roles", user.getRoles().stream().map(Role::name).toList())
                .sign(algorithm);
    }
}
