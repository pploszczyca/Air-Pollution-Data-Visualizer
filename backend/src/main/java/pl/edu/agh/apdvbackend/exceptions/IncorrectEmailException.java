package pl.edu.agh.apdvbackend.exceptions;

public class IncorrectEmailException extends Exception {
    private static final String EMAIL = "Email: ";
    private static final String IS_NOT_CORRECT = " is not correct";

    public IncorrectEmailException(String email) {
        super(EMAIL + email + IS_NOT_CORRECT);
    }
}
