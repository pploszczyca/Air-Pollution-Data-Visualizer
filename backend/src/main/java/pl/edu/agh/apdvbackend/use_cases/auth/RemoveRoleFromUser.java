package pl.edu.agh.apdvbackend.use_cases.auth;

import pl.edu.agh.apdvbackend.models.body_models.auth.UserWithRoles;

public interface RemoveRoleFromUser {
    UserWithRoles execute(Long userId, String role);
}
