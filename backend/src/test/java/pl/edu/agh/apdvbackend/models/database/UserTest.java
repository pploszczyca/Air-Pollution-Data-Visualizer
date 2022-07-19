package pl.edu.agh.apdvbackend.models.database;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.Test;
import pl.edu.agh.apdvbackend.fakes.UserFakes;

class UserTest {
    @Test
    public void addRoleToUser() {
        final var user = UserFakes.getUser();
        final var role = Role.USER;

        final var result = user.addRole(role);

        assertTrue(result);
        assertTrue(user.getRoles().contains(role));
    }

    @Test
    public void removeRoleFromUser() {
        final var user = UserFakes.getUser();
        final var role = Role.ADMIN;
        user.addRole(role);

        final var result = user.removeRole(Role.ADMIN);

        assertTrue(result);
        assertFalse(user.getRoles().contains(role));
    }

    @Test
    public void addShouldReturnFalseWhenUserHasRole() {
        final var user = UserFakes.getUser();
        final var role = Role.USER;
        final var theSameRole = Role.USER;
        user.addRole(role);

        final var result = user.addRole(theSameRole);

        assertFalse(result);
    }

    @Test
    public void removeShouldReturnFalseWhenUserDoesntHaveRole() {
        final var user = UserFakes.getUser();
        final var role = Role.USER;

        final var result = user.removeRole(role);

        assertFalse(result);
    }
}
