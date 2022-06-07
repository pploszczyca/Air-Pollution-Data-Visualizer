package pl.edu.agh.apdvbackend.exceptions;

import java.util.NoSuchElementException;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import pl.edu.agh.apdvbackend.models.body_models.Response;

@RestControllerAdvice
public class RestResponseExceptionHandler {

    private static final String NO_SUCH_ELEMENT = "Element doesn't exist.";

    private static final String SAVING_FAILED = "Saving failed, maybe element already exists.";

    private static final String ELEMENT_DOESN_T_EXISTS = "Can't delete, element doesn't exists.";

    private static final String NO_DATAHUB_CONNECTION = "No connection with DataHub, check if your VPN is running.";

    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    @ExceptionHandler(NoSuchElementException.class)
    public Response<?> handleNoSuchElement() {
        return Response.withError(NO_SUCH_ELEMENT);
    }

    @ResponseStatus(value = HttpStatus.CONFLICT)
    @ExceptionHandler(ConstraintViolationException.class)
    public Response<?> handleConstraintViolationException() {
        return Response.withError(SAVING_FAILED);
    }

    @ResponseStatus(value = HttpStatus.CONFLICT)
    @ExceptionHandler(EmptyResultDataAccessException.class)
    public Response<?> handleEmptyResultDataAccessException() {
        return Response.withError(ELEMENT_DOESN_T_EXISTS);
    }

    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    @ExceptionHandler({IncorrectEmailException.class,
            IncorrectNameException.class})
    public Response<?> handleUserDataExceptions(Exception exception) {
        return Response.withError(exception.getMessage());
    }

    @ResponseStatus(value = HttpStatus.BAD_GATEWAY)
    @ExceptionHandler(WebClientResponseException.class)
    public Response<?> handleWebClientResponseException() {
        return Response.withError(NO_DATAHUB_CONNECTION);
    }
}
