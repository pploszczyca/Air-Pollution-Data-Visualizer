package pl.edu.agh.apdvbackend.controllers.group.body_models;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.EnableEndpointInfo;
import pl.edu.agh.apdvbackend.models.body_models.ShortUserInfo;

public record AboutGroupResponseBody(
        @Schema(required = true) Long id,
        @Schema(required = true) String name,
        @Schema(required = true) List<ShortUserInfo> shortUserInfos,
        @Schema(required = true) List<EnableEndpointInfo> enableEndpointInfos
) {
}
