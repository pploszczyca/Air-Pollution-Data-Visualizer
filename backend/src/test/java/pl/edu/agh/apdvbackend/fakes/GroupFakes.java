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
    public static Group buildNewGroup(
            Long id,
            String name,
            Set<User> usersInGroup,
            List<GroupEndpoint> groupEndpoints
    ) {
        final var group = new Group();
        group.setId(id);
        group.setName(name);
        group.setUsersInGroup(usersInGroup);
        group.setGroupEndpoints(groupEndpoints);

        return group;
    }
}
