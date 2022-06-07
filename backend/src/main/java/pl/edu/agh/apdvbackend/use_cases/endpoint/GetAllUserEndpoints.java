package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.Endpoint;

public interface GetAllUserEndpoints {
    List<UserEndpointResponseBody> execute(Long userId);
}
