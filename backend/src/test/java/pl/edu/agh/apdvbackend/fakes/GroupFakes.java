package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import pl.edu.agh.apdvbackend.models.database.Group;

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
}
