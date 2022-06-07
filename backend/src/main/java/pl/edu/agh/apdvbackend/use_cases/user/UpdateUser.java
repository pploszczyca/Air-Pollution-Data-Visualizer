package pl.edu.agh.apdvbackend.use_cases.user;

import pl.edu.agh.apdvbackend.controllers.user.body_models.AddUserRequestBody;
import pl.edu.agh.apdvbackend.models.User;

public interface UpdateUser {
    User execute(Long userId, AddUserRequestBody addUserRequestBody);
}
