package pl.edu.agh.apdvbackend.exceptions;

import java.util.NoSuchElementException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import org.hibernate.exception.ConstraintViolationException;

@RestControllerAdvice
public class RestResponseExceptionHandler {

    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    @ExceptionHandler(NoSuchElementException.class)
    public Response<?> handleNoSuchElement() {
        return Response.withError("Element doesn't exist.");
    }

    @ResponseStatus(value = HttpStatus.CONFLICT)
    @ExceptionHandler(ConstraintViolationException.class)
    public Response<?> handleConstraintViolationException() {
        return Response.withError("Saving failed, maybe element already exists.");
    }

    @ResponseStatus(value = HttpStatus.CONFLICT)
    @ExceptionHandler(EmptyResultDataAccessException.class)
    public Response<?> handleEmptyResultDataAccessException() {
        return Response.withError("Can't delete, element doesn't exists.");
    }

    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    @ExceptionHandler({IncorrectEmailException.class, IncorrectNameException.class})
    public Response<?> handleUserDataExceptions(Exception exception) {
        return Response.withError(exception.getMessage());
    }

    @ResponseStatus(value = HttpStatus.BAD_GATEWAY)
    @ExceptionHandler(WebClientResponseException.class)
    public Response<?> handleWebClientResponseException() {
        return Response.withError("No connection with DataHub, check if your VPN is running.");
    }
}
