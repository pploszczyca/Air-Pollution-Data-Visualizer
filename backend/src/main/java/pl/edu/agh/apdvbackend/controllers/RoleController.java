package pl.edu.agh.apdvbackend.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.auth.UserWithRoles;
import pl.edu.agh.apdvbackend.services.RoleService;

import static pl.edu.agh.apdvbackend.configs.SwaggerConfig.JWT_AUTH;

@RestController
@RequestMapping("/role")
@RequiredArgsConstructor
@Tag(name = "Role")
public class RoleController {

    private final RoleService roleService;

    @Operation(
            summary = "Add role to user",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @PostMapping
    public Response<UserWithRoles> addRoleToUser(
            Long userId,
            String roleName
    ) {
        return roleService.addRoleToUser(userId, roleName);
    }

    @Operation(
            summary = "Remove role from user",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @DeleteMapping
    public Response<UserWithRoles> removeUserFromRole(
            Long userId,
            String roleName
    ) {
        return roleService.removeUserFromRole(userId, roleName);
    }
}
