package pl.edu.agh.apdvbackend.exceptions;

public class IncorrectAuthorizationHeaderException extends Exception{

    public static final String INCORRECT_AUTHORIZATION_HEADER =
            "Incorrect Authorization Header. Check if JWT is proper";

    public IncorrectAuthorizationHeaderException() {
        super(INCORRECT_AUTHORIZATION_HEADER);
    }
}
