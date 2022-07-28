package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.EndpointGroupRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.group.AddGroupRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupInfoResponseBody;
import pl.edu.agh.apdvbackend.use_cases.group.AddNewGroup;
import pl.edu.agh.apdvbackend.use_cases.group.AddUserToGroup;
import pl.edu.agh.apdvbackend.use_cases.group.ChangeEnableEndpointsInGroup;
import pl.edu.agh.apdvbackend.use_cases.group.GetAboutGroupInfo;
import pl.edu.agh.apdvbackend.use_cases.group.GetAllGroupsInfo;
import pl.edu.agh.apdvbackend.use_cases.group.RemoveGroup;
import pl.edu.agh.apdvbackend.use_cases.group.RemoveUserFromGroup;

@Service
@RequiredArgsConstructor
public class GroupService {

    private final GetAllGroupsInfo getAllGroupsInfo;

    private final GetAboutGroupInfo getAboutGroupInfo;

    private final AddUserToGroup addUserToGroup;

    private final RemoveUserFromGroup removeUserFromGroup;

    private final RemoveGroup removeGroup;

    private final ChangeEnableEndpointsInGroup changeEnableEndpointsInGroup;

    private final AddNewGroup addNewGroup;

    public Response<List<ShortGroupInfoResponseBody>> getAllGroupsInfo() {
        return Response.withOkStatus(getAllGroupsInfo.execute());
    }

    public Response<AboutGroupResponseBody> getGroupInfo(Long groupId) {
        return Response.withOkStatus(getAboutGroupInfo.execute(groupId));
    }

    public Response<AboutGroupResponseBody> addUserToGroup(Long groupId,
                                                           Long userId) {
        return Response.withOkStatus(addUserToGroup.execute(groupId, userId));
    }

    public Response<AboutGroupResponseBody> removeUserFromGroup(Long groupId,
                                                                Long userId) {
        return Response.withOkStatus(
                removeUserFromGroup.execute(groupId, userId));
    }

    public void removeGroup(Long groupId) {
        removeGroup.execute(groupId);
    }

    public Response<AboutGroupResponseBody> changeEnableEndpoints(
            List<EndpointGroupRequestBody> endpointGroupRequestBodyList,
            Long groupId) {
        return Response.withOkStatus(changeEnableEndpointsInGroup.execute(
                endpointGroupRequestBodyList, groupId));
    }

    public Response<AboutGroupResponseBody> addGroup(
            AddGroupRequestBody addGroupRequestBody) {
        return Response.withOkStatus(addNewGroup.execute(addGroupRequestBody));
    }
}
