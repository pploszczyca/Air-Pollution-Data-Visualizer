package pl.edu.agh.apdvbackend.models.body_models.user;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Role;

public record UserResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) String email,
        @Schema(required = true) List<Role> roles,
        @Schema(required = true) List<ShortGroupResponseBody> groups
) {
}
