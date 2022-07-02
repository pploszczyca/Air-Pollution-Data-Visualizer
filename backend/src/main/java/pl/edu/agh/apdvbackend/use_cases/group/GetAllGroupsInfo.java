package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupInfoResponseBody;

public interface GetAllGroupsInfo {
    List<ShortGroupInfoResponseBody> execute();
}
