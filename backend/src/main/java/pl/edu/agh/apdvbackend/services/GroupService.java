package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.group.AboutGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.EndpointGroupRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupMembersResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;
import pl.edu.agh.apdvbackend.use_cases.group.AddNewGroup;
import pl.edu.agh.apdvbackend.use_cases.group.AddUserToGroup;
import pl.edu.agh.apdvbackend.use_cases.group.ChangeEnableEndpointsInGroup;
import pl.edu.agh.apdvbackend.use_cases.group.GetAdminPanelGroup;
import pl.edu.agh.apdvbackend.use_cases.group.GetAllGroupsInfo;
import pl.edu.agh.apdvbackend.use_cases.group.GetGroupMembers;
import pl.edu.agh.apdvbackend.use_cases.group.GetNotMembersOfTheGroup;
import pl.edu.agh.apdvbackend.use_cases.group.RemoveGroup;
import pl.edu.agh.apdvbackend.use_cases.group.RemoveUserFromGroup;

@Service
@RequiredArgsConstructor
public class GroupService {

    private final GetAllGroupsInfo getAllGroupsInfo;
    private final AddUserToGroup addUserToGroup;
    private final RemoveUserFromGroup removeUserFromGroup;
    private final RemoveGroup removeGroup;
    private final ChangeEnableEndpointsInGroup changeEnableEndpointsInGroup;
    private final AddNewGroup addNewGroup;
    private final GetNotMembersOfTheGroup getNotMembersOfTheGroup;
    private final GetGroupMembers getGroupMembers;
    private final GetAdminPanelGroup getAdminPanelGroup;

    public Response<List<ShortGroupResponseBody>> getAllGroupsInfo() {
        return Response.withOkStatus(getAllGroupsInfo.execute());
    }

    public Response<AboutGroupResponseBody> addUserToGroup(
            Long groupId,
            Long userId
    ) {
        return Response.withOkStatus(addUserToGroup.execute(groupId, userId));
    }

    public Response<AboutGroupResponseBody> removeUserFromGroup(
            Long groupId,
            Long userId
    ) {
        return Response.withOkStatus(removeUserFromGroup.execute(groupId, userId));
    }

    public void removeGroup(Long groupId) {
        removeGroup.execute(groupId);
    }

    public Response<AboutGroupResponseBody> changeEnableEndpoints(
            List<EndpointGroupRequestBody> endpointGroupRequestBodyList,
            Long groupId
    ) {
        return Response.withOkStatus(changeEnableEndpointsInGroup.execute(endpointGroupRequestBodyList, groupId));
    }

    public Response<AboutGroupResponseBody> addGroup(
            GroupRequestBody groupRequestBody
    ) {
        return Response.withOkStatus(addNewGroup.execute(groupRequestBody));
    }

    public Response<List<ShortUserResponseBody>> getNotMembersOfTheGroup(Long groupId) {
        return Response.withOkStatus(getNotMembersOfTheGroup.execute(groupId));
    }

    public Response<GroupMembersResponseBody> getGroupMembers(Long groupId) {
        return Response.withOkStatus(getGroupMembers.execute(groupId));
    }

    public Response<AdminPanelGroupResponseBody> getAdminPanelGroup(Long groupId) {
        return Response.withOkStatus(getAdminPanelGroup.execute(groupId));
    }
}
