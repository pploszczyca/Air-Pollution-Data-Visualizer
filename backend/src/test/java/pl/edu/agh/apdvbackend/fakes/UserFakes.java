package pl.edu.agh.apdvbackend.fakes;

import java.util.Set;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.models.database.Role;
import pl.edu.agh.apdvbackend.models.database.User;

public class UserFakes {
    public static final long USER_ID = 9999L;

    public static User getUser() {
        final var user = new User();
        user.setId(USER_ID);
        user.setEmail("dummy.user@email.com");
        user.setPassword("dummy password");

        return user;
    }

    @Builder
    public static User buildNewUser(
            Long id,
            String email,
            String password,
            Set<Group> groups,
            Set<Role> roles
    ) {
        final var user = new User();
        user.setId(id);
        user.setEmail(email);
        user.setPassword(password);
        user.setGroups(groups);
        user.setRoles(roles);

        return user;
    }
}
