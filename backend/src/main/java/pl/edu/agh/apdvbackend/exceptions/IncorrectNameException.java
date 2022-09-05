package pl.edu.agh.apdvbackend.exceptions;

public class IncorrectNameException extends Exception {
    private static final String NAME = "Name: ";
    private static final String IS_NOT_CORRECT = " is not correct";

    public IncorrectNameException(String name) {
        super(NAME + name + IS_NOT_CORRECT);
    }
}
