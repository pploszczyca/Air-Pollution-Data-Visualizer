package pl.edu.agh.apdvbackend.use_cases.auth;

import javax.servlet.http.HttpServletRequest;
import pl.edu.agh.apdvbackend.models.body_models.auth.JWTResponse;

public interface RefreshToken {
    JWTResponse execute(HttpServletRequest request);
}
