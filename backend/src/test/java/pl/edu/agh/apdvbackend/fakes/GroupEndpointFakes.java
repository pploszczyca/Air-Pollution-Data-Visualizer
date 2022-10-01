package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import java.util.List;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;
import pl.edu.agh.apdvbackend.models.database.GroupEndpointKey;

public class GroupEndpointFakes {

    public static GroupEndpoint getGroupEndpoint() {
        final var groupEndpoint = new GroupEndpoint();
        groupEndpoint.setId(GroupEndpointKeyFakes.getGroupEndpointKey());
        groupEndpoint.setGroup(GroupFakes.getGroup());
        groupEndpoint.setEndpoint(EndpointFakes.getEndpoint());
        groupEndpoint.setEnableFields(Collections.emptyList());

        return groupEndpoint;
    }

    @Builder
    private static GroupEndpoint buildNewGroupEndpoint(
            GroupEndpointKey id,
            Group group,
            Endpoint endpoint,
            List<Field> enableFields
    ) {
        final var groupEndpoint = new GroupEndpoint();
        groupEndpoint.setId(getOrElse(id, GroupEndpointKeyFakes.getGroupEndpointKey()));
        groupEndpoint.setGroup(getOrElse(group, GroupFakes.getGroup()));
        groupEndpoint.setEndpoint(getOrElse(endpoint, EndpointFakes.getEndpoint()));
        groupEndpoint.setEnableFields(getOrElse(enableFields, Collections.emptyList()));

        return groupEndpoint;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
