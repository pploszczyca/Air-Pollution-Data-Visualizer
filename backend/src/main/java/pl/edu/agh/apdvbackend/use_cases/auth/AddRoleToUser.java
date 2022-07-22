package pl.edu.agh.apdvbackend.use_cases.auth;

import pl.edu.agh.apdvbackend.models.body_models.auth.UserWithRoles;

public interface AddRoleToUser {
    UserWithRoles execute(Long userId, String roleName);
}
