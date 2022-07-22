package pl.edu.agh.apdvbackend.models.body_models.auth;

import java.util.List;
import pl.edu.agh.apdvbackend.models.database.Role;

public record UserWithRoles(
        Long id,
        String name,
        String email,
        List<Role> roles
) {
}
