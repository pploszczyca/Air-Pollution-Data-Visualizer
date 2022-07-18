package pl.edu.agh.apdvbackend.models.body_models.group;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EnableEndpointInfo;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserInfo;

public record AboutGroupResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) String name,
        @Schema(required = true) List<ShortUserInfo> shortUserInfos,
        @Schema(required = true) List<EnableEndpointInfo> enableEndpointInfos
) {
}
