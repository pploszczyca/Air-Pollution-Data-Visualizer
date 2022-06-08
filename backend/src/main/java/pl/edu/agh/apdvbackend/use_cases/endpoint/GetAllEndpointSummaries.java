package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.EndpointSummaryResponseBody;

public interface GetAllEndpointSummaries {
    List<EndpointSummaryResponseBody> execute();
}
