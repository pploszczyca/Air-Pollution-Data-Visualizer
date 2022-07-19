package pl.edu.agh.apdvbackend.auth;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import static org.springframework.http.HttpHeaders.AUTHORIZATION;
import static org.springframework.http.HttpStatus.FORBIDDEN;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
@RequiredArgsConstructor
public class CustomAuthorizationFilter extends OncePerRequestFilter {

    private static final String TOKEN_PREFIX = "Bearer ";

    private static final String ROLES = "roles";

    private static final String ERROR = "error";

    private final Algorithm algorithm;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {
        final var authorizationHeader = request.getHeader(AUTHORIZATION);
        if (!isAuthorizationHeaderFormatProper(authorizationHeader)) {
            filterChain.doFilter(request, response);
            return;
        }

        try {
            tryToUpdateSecurityContext(request, response, filterChain,
                    authorizationHeader);
        } catch (Exception exception) {
            sendErrorResponse(response, exception);
        }
    }

    private boolean isAuthorizationHeaderFormatProper(
            String authorizationHeader) {
        return authorizationHeader != null &&
                authorizationHeader.startsWith(TOKEN_PREFIX);
    }

    private void tryToUpdateSecurityContext(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain filterChain,
                                            String authorizationHeader)
            throws IOException, ServletException {
        final var token =
                authorizationHeader.substring(TOKEN_PREFIX.length());
        final JWTVerifier verifier = JWT.require(algorithm).build();
        final var decodedJWT = verifier.verify(token);
        final var username = decodedJWT.getSubject();
        final var roles = getRoles(decodedJWT);
        final var authenticationToken =
                new UsernamePasswordAuthenticationToken(username, null, roles);
        SecurityContextHolder.getContext()
                .setAuthentication(authenticationToken);
        filterChain.doFilter(request, response);
    }

    private List<SimpleGrantedAuthority> getRoles(DecodedJWT decodedJWT) {
        return Arrays.stream(decodedJWT
                        .getClaim(ROLES)
                        .asArray(String.class))
                .map(SimpleGrantedAuthority::new)
                .toList();
    }

    private void sendErrorResponse(HttpServletResponse response,
                                   Exception exception)
            throws IOException {
        response.setHeader(ERROR, exception.getMessage());
        response.sendError(FORBIDDEN.value());
    }
}
