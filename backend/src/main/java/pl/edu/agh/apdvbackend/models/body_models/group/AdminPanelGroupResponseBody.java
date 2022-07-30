package pl.edu.agh.apdvbackend.models.body_models.group;

import java.util.List;
import pl.edu.agh.apdvbackend.models.database.FieldType;

public record AdminPanelGroupResponseBody(
        Long groupId,
        String groupName,
        List<Endpoint> endpoints
) {
    public record Endpoint(
            Long id,
            String label,
            int endpointNumber,
            List<Field> fields,
            boolean isBelongingToGroup
    ) {
        public record Field(
            Long id,
            String label,
            FieldType fieldType,
            String unitName,
            boolean isBelongingToGroup
        ){
        }
    }
}
