package pl.edu.agh.apdvbackend.exceptions;

public class IncorrectNodeDeserialize extends Exception{
    public static final String LABEL_CAN_T_BE_DESERIALIZE =
            " label can't be deserialize";

    public IncorrectNodeDeserialize(String label) {
        super(label + LABEL_CAN_T_BE_DESERIALIZE);
    }
}
