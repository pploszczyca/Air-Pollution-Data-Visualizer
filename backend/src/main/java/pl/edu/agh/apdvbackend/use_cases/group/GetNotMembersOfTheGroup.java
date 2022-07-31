package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;

public interface GetNotMembersOfTheGroup {

    List<ShortUserResponseBody> execute(Long groupId);
}
