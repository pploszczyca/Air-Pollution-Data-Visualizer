package pl.edu.agh.apdvbackend.use_cases.validation;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AddUserRequestBody;
import pl.edu.agh.apdvbackend.exceptions.IncorrectEmailException;
import pl.edu.agh.apdvbackend.exceptions.IncorrectNameException;
import pl.edu.agh.apdvbackend.utilities.UserDataValidationUtilities;

@Component
@RequiredArgsConstructor
public class ValidateAddUserRequestBodyImpl
        implements ValidateAddUserRequestBody {

    private final UserDataValidationUtilities userDataValidationUtilities;

    @Override
    public void execute(AddUserRequestBody addUserRequestBody)
            throws IncorrectEmailException, IncorrectNameException {
        final var email = addUserRequestBody.email();
        final var name = addUserRequestBody.name();

        if (!userDataValidationUtilities.validateEmail(email)) {
            throw new IncorrectEmailException(email);
        } else if (!userDataValidationUtilities.validateName(name)) {
            throw new IncorrectNameException(name);
        }
    }
}
