package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.endpoint.EndpointRequestBodyMapper;
import pl.edu.agh.apdvbackend.mappers.endpoint.EndpointResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;

@Component
@RequiredArgsConstructor
public class UpdateEndpointImpl implements UpdateEndpoint {

    private final GetEndpoint getEndpoint;
    private final EndpointRepository endpointRepository;
    private final EndpointRequestBodyMapper endpointRequestBodyMapper;
    private final EndpointResponseBodyMapper mapper;

    @Override
    public EndpointResponseBody execute(
            EndpointRequestBody endpointRequestBody,
            Long endpointId
    ) {
        final var endpoint = getEndpoint.execute(endpointId);

        endpointRequestBodyMapper.updateEndpoint(endpointRequestBody, endpoint);
        final var savedEndpoint = endpointRepository.save(endpoint);

        return mapper.toResponseBody(savedEndpoint);
    }
}
