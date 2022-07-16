package pl.edu.agh.apdvbackend.filters;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import java.io.IOException;
import java.util.Date;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@RequiredArgsConstructor
public class CustomAuthenticationFilter extends
        UsernamePasswordAuthenticationFilter {

    private static final String USERNAME = "username";

    private static final String PASSWORD = "password";

    private static final String SECRET = "secret";

    private static final int ACCESS_TOKEN_EXPIRES_TIME = 10 * 60 * 1000;

    private static final int REFRESH_TOKEN_EXPIRES_TIME = 30 * 60 * 1000;

    private final AuthenticationManager authenticationManager;

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request,
                                                HttpServletResponse response)
            throws AuthenticationException {
        final var username = request.getParameter(USERNAME);
        final var password = request.getParameter(PASSWORD);
        final var authenticationToken = new UsernamePasswordAuthenticationToken(username, password);

        return authenticationManager.authenticate(authenticationToken);
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain chain,
                                            Authentication authentication)
            throws IOException, ServletException {
        final var user = (User) authentication.getPrincipal();
        final var algorithm = Algorithm.HMAC256(SECRET.getBytes());
        final String access_token = JWT.create()
                .withSubject(user.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() +
                        ACCESS_TOKEN_EXPIRES_TIME))
                .withIssuer(request.getRequestURL().toString())
                .withClaim("id", user.getPassword())
                .sign(algorithm);
        final String refresh_token = JWT.create()
                .withSubject(user.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() +
                        REFRESH_TOKEN_EXPIRES_TIME))
                .withIssuer(request.getRequestURL().toString())
                .withClaim("id", user.getPassword())
                .sign(algorithm);

        response.setHeader("access_token", access_token);
        response.setHeader("refresh_roken", refresh_token);
    }
}
