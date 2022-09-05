package pl.edu.agh.apdvbackend.utilities;

import pl.edu.agh.apdvbackend.models.database.User;

public interface JwtTokenUtils {
    String generateAccessToken(User user);

    String generateRefreshToken(User user);
}
