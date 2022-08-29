package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;

public interface GetAllEndpointSummaries {
    List<EndpointResponseBody> execute();
}
