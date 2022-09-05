package pl.edu.agh.apdvbackend.use_cases.user;

import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;

public interface GetAboutUser {
    UserResponseBody execute(Long userId);
}
