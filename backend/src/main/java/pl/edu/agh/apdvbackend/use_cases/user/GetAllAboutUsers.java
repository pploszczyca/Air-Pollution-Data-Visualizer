package pl.edu.agh.apdvbackend.use_cases.user;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;

public interface GetAllAboutUsers {
    List<UserResponseBody> execute();
}
