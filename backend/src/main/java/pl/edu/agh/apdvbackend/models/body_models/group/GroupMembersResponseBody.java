package pl.edu.agh.apdvbackend.models.body_models.group;

import java.util.List;
import pl.edu.agh.apdvbackend.models.database.Role;

public record GroupMembersResponseBody(
        Long groupId,
        String groupName,
        List<Member> members
) {
    public record Member(
            Long id,
            String email,
            List<String> otherGroupNames,
            List<Role> roles
    ) {
    }
}
