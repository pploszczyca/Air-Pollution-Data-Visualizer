package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.endpoint.EndpointResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;

@Component
@RequiredArgsConstructor
public class GetEndpointSummaryImpl implements GetEndpointSummary {

    private final GetEndpoint getEndpoint;
    private final EndpointResponseBodyMapper mapper;

    @Override
    public EndpointResponseBody execute(Long endpointId) {
        final var endpoint = getEndpoint.execute(endpointId);
        return mapper.toResponseBody(endpoint);
    }
}
