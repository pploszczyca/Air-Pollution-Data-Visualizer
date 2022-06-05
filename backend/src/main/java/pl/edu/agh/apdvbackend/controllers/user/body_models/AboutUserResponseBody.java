package pl.edu.agh.apdvbackend.controllers.user.body_models;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.controllers.group.body_models.ShortGroupInfoResponseBody;

public record AboutUserResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) String name,
        @Schema(required = true) String email,
        @Schema(required = true) List<ShortGroupInfoResponseBody> userGroups
        ) {
}
