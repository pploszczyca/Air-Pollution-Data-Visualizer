package pl.edu.agh.apdvbackend.exceptions;

public class IncorrectNameException extends Exception{
    public IncorrectNameException(String name) {
        super("Name: " + name + " is not correct");
    }
}
