package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.controllers.group.body_models.AddEnableEndpointRequestBody;
import pl.edu.agh.apdvbackend.controllers.group.body_models.ShortGroupInfoResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.use_cases.group.GetAboutGroupInfo;
import pl.edu.agh.apdvbackend.use_cases.group.GetAllGroupsInfo;

@Service
@RequiredArgsConstructor
public class GroupService {

    private final GetAllGroupsInfo getAllGroupsInfo;

    private final GetAboutGroupInfo getAboutGroupInfo;

    public Response<List<ShortGroupInfoResponseBody>> getAllGroupsInfo() {
        return Response.withOkStatus(getAllGroupsInfo.execute());
    }

    public Response<AboutGroupResponseBody> getGroupInfo(Long groupId) {
        return Response.withOkStatus(getAboutGroupInfo.execute(groupId));
    }

    public void addUserToGroup(Long groupId, Long userId) {
    }

    public void removeUserFromGroup(Long groupId, Long userId) {
    }

    public Response<AboutGroupResponseBody> changeEnableEndpoints(List<AddEnableEndpointRequestBody> addEnableEndpointRequestBodyList) {
        return Response.withOkStatus(null);
    }
}
