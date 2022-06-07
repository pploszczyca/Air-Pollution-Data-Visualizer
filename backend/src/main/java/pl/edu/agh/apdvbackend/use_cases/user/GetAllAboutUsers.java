package pl.edu.agh.apdvbackend.use_cases.user;

import java.util.List;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AboutUserResponseBody;

public interface GetAllAboutUsers {
    List<AboutUserResponseBody> execute();
}
