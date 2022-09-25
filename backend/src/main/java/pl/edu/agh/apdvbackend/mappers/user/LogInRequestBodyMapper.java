package pl.edu.agh.apdvbackend.mappers.user;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.auth.LogInRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;

@Mapper(componentModel = "spring")
public interface LogInRequestBodyMapper {
    LogInRequestBody toLogInRequestBody(UserRequestBody userRequestBody);
}
