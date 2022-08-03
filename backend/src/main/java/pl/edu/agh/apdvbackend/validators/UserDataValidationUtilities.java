package pl.edu.agh.apdvbackend.validators;

import java.util.regex.Pattern;
import pl.edu.agh.apdvbackend.exceptions.IncorrectEmailException;

public class UserDataValidationUtilities {
    /**
     * Function to validate email based on <a href="https://www.baeldung.com/java-email-validation-regex">this article</a>.
     * <br><br>
     * Rules to local part:
     * <ul>
     *  <li>It allows numeric values from 0 to 9,</li>
     *  <li>Both uppercase and lowercase letters from a to z are allowed,</li>
     *  <li>Allowed are underscore “_”, hyphen “-“, and dot “.”,</li>
     *  <li>Dot isn't allowed at the start and end of the local part,</li>
     *  <li>Consecutive dots aren't allowed,</li>
     *  <li>For the local part, a maximum of 64 characters are allowed.</li>
     * </ul>
     * Rules to domain part:
     * <ul>
     *  <li>It allows numeric values from 0 to 9,</li>
     *  <li>We allow both uppercase and lowercase letters from a to z,</li>
     *  <li>Hyphen “-” and dot “.” aren't allowed at the start and end of the domain part,</li>
     *  <li>No consecutive dots.</li>
     * </ul>
     */
    public void validateEmail(String email) throws IncorrectEmailException {
        final String regexPattern =
                "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
                        +
                        "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";

        if (!patternMatches(email, regexPattern)) {
            throw new IncorrectEmailException(email);
        }
    }

    private boolean patternMatches(String stringToMach, String regexPattern) {
        return Pattern.compile(regexPattern)
                .matcher(stringToMach)
                .matches();
    }
}
