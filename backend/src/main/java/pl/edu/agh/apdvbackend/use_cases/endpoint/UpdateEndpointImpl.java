package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.endpoint.EndpointRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;

@Component
@RequiredArgsConstructor
public class UpdateEndpointImpl implements UpdateEndpoint {

    private final GetEndpoint getEndpoint;
    private final EndpointRepository endpointRepository;
    private final EndpointRequestBodyMapper endpointRequestBodyMapper;

    @Override
    public Endpoint execute(
            EndpointRequestBody endpointRequestBody,
            Long endpointId
    ) {
        final var endpoint = getEndpoint.execute(endpointId);

        endpointRequestBodyMapper.updateEndpoint(endpointRequestBody, endpoint);

        return endpointRepository.save(endpoint);
    }
}
