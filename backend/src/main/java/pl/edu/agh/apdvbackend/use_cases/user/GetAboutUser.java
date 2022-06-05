package pl.edu.agh.apdvbackend.use_cases.user;

import pl.edu.agh.apdvbackend.controllers.user.body_models.AboutUserResponseBody;

public interface GetAboutUser {
    AboutUserResponseBody execute(Long userId);
}
