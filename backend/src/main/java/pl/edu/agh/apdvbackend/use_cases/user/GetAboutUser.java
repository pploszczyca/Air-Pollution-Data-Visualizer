package pl.edu.agh.apdvbackend.use_cases.user;

import pl.edu.agh.apdvbackend.models.body_models.user.AboutUserResponseBody;

public interface GetAboutUser {
    AboutUserResponseBody execute(Long userId);
}
