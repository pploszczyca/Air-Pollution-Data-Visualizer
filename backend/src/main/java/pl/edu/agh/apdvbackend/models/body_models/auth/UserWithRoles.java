package pl.edu.agh.apdvbackend.models.body_models.auth;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.database.Role;

public record UserWithRoles(
        @Schema(required = true) Long id,
        @Schema(required = true) String name,
        @Schema(required = true) String email,
        @Schema(required = true) List<Role> roles
) {
}
