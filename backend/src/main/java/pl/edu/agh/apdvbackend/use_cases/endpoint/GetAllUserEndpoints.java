package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;

public interface GetAllUserEndpoints {
    List<UserEndpointResponseBody> execute(Long userId);
}
