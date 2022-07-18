package pl.edu.agh.apdvbackend.use_cases.user;

import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;
import pl.edu.agh.apdvbackend.models.database.User;

public interface UpdateUser {
    User execute(Long userId, AddUserRequestBody addUserRequestBody);
}
