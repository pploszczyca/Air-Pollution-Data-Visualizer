package pl.edu.agh.apdvbackend.validators;

public class AuthorizationHeaderValidation {
    private static final String TOKEN_PREFIX = "Bearer ";

    public boolean isFormatProper(String authorizationHeader) {
        return authorizationHeader != null &&
                authorizationHeader.startsWith(TOKEN_PREFIX);
    }
}
