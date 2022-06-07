package pl.edu.agh.apdvbackend.use_cases.user;

import pl.edu.agh.apdvbackend.models.User;

public interface GetUser {
    User execute(Long userId);
}
