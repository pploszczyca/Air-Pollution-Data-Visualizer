package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUser;

public interface GetNotMembersOfTheGroup {

    List<ShortUser> execute(Long groupId);
}
