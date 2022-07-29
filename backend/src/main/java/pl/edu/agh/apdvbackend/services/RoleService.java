package pl.edu.agh.apdvbackend.services;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.auth.UserWithRoles;
import pl.edu.agh.apdvbackend.use_cases.auth.AddRoleToUser;
import pl.edu.agh.apdvbackend.use_cases.auth.RemoveRoleFromUser;

@Service
@RequiredArgsConstructor
public class RoleService {

    private final AddRoleToUser addRoleToUser;

    private final RemoveRoleFromUser removeRoleFromUser;

    public Response<UserWithRoles> addRoleToUser(Long userId, String roleName) {
        return Response.withOkStatus(addRoleToUser.execute(userId, roleName));
    }

    public Response<UserWithRoles> removeUserFromRole(Long userId,
                                                      String roleName) {
        return Response.withOkStatus(
                removeRoleFromUser.execute(userId, roleName));
    }
}
