package pl.edu.agh.apdvbackend.mappers.endpoint;

import java.util.List;
import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

@Mapper(componentModel = "spring")
public interface UserEndpointResponseBodyMapper {
    UserEndpointResponseBody toResponseBody(Endpoint endpoint);

    List<UserEndpointResponseBody> toResponseBodyList(List<Endpoint> endpoints);
}
