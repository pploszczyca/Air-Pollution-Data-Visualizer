package pl.edu.agh.apdvbackend.mappers.user;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import pl.edu.agh.apdvbackend.models.body_models.auth.UserWithRoles;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserWithRolesMapper {
    UserWithRoles toUserWithRoles(User user);
}
