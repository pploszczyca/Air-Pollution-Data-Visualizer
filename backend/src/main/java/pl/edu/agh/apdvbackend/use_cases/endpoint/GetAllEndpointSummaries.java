package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointSummaryResponseBody;

public interface GetAllEndpointSummaries {
    List<EndpointSummaryResponseBody> execute();
}
