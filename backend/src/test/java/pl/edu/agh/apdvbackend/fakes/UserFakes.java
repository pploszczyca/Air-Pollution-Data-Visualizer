package pl.edu.agh.apdvbackend.fakes;

import pl.edu.agh.apdvbackend.models.database.User;

public class UserFakes {
    public static User getUser() {
        final var user = new User();
        user.setId(9999L);
        user.setName("dummy user");
        user.setEmail("dummy.user@email.com");
        user.setPassword("dummy password");

        return user;
    }
}
