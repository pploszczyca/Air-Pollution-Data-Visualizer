package pl.edu.agh.apdvbackend.use_cases.validation;

import pl.edu.agh.apdvbackend.exceptions.IncorrectEmailException;
import pl.edu.agh.apdvbackend.exceptions.IncorrectNameException;
import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;

public interface ValidateAddUserRequestBody {
    void execute(AddUserRequestBody addUserRequestBody)
            throws IncorrectEmailException, IncorrectNameException;
}
