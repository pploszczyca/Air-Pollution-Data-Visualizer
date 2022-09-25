package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
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
        user.setEmail(getOrElse(email, "dummy.user@email.com"));
        user.setPassword(getOrElse(password, "dummy password"));
        user.setGroups(getOrElse(groups, Collections.emptySet()));
        user.setRoles(getOrElse(roles, Collections.emptySet()));

        return user;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
