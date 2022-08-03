package pl.edu.agh.apdvbackend.models.body_models.group;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;

public record AboutGroupResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) String name,
        @Schema(required = true) List<ShortUserResponseBody> shortUserInfos,
        @Schema(required = true) List<GroupEndpointResponseBody> groupEndpointResponseBodies
) {
}
