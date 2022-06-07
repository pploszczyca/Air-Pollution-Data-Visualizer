package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import pl.edu.agh.apdvbackend.controllers.group.body_models.ShortGroupInfoResponseBody;

public interface GetAllGroupsInfo {
    List<ShortGroupInfoResponseBody> execute();
}
