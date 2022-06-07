package pl.edu.agh.apdvbackend.use_cases.validation;

import pl.edu.agh.apdvbackend.controllers.user.body_models.AddUserRequestBody;
import pl.edu.agh.apdvbackend.exceptions.IncorrectEmailException;
import pl.edu.agh.apdvbackend.exceptions.IncorrectNameException;

public interface ValidateAddUserRequestBody {
    void execute(AddUserRequestBody addUserRequestBody)
            throws IncorrectEmailException, IncorrectNameException;
}
