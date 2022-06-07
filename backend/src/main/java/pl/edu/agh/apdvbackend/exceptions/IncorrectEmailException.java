package pl.edu.agh.apdvbackend.exceptions;

public class IncorrectEmailException extends Exception{
    public IncorrectEmailException(String email) {
        super("Email: " + email + " is not correct");
    }
}
