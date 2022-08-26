package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;

public interface GetAllGroupsInfo {
    List<ShortGroupResponseBody> execute();
}
