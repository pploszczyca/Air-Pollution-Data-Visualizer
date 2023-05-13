package pl.edu.agh.apdvbackend.models.body_models.group;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;

public record AboutGroupResponseBody(
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) Long id,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) String name,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) List<ShortUserResponseBody> shortUserInfos,
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED) List<GroupEndpointResponseBody> groupEndpointResponseBodies
) {
}
