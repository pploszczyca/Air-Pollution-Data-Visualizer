package pl.edu.agh.apdvbackend.use_cases.user;

import pl.edu.agh.apdvbackend.models.database.User;

public interface GetUser {
    User execute(Long userId);
}
