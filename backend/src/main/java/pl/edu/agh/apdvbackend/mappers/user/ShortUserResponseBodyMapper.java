package pl.edu.agh.apdvbackend.mappers.user;

import java.util.List;
import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring")
public interface ShortUserResponseBodyMapper {
    ShortUserResponseBody toShortUser(User user);

    List<ShortUserResponseBody> toShortUserList(List<User> users);
}
