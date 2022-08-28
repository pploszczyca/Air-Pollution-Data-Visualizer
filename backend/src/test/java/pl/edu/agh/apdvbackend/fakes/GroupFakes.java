package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;
import pl.edu.agh.apdvbackend.models.database.User;

public class GroupFakes {

    public static final long GROUP_ID = 99L;

    public static Group getGroup() {
        final var group = new Group();
        group.setId(GROUP_ID);
        group.setName("dummy group name");
        group.setUsersInGroup(Collections.emptySet());
        group.setGroupEndpoints(Collections.emptyList());

        return group;
    }

    @Builder
    private static Group buildNewGroup(
            Long id,
            String name,
            Set<User> usersInGroup,
            List<GroupEndpoint> groupEndpoints
    ) {
        final var group = new Group();
        group.setId(id);
        group.setName(getOrElse(name, "dummy group name"));
        group.setUsersInGroup(getOrElse(usersInGroup, Collections.emptySet()));
        group.setGroupEndpoints(getOrElse(groupEndpoints, Collections.emptyList()));

        return group;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
