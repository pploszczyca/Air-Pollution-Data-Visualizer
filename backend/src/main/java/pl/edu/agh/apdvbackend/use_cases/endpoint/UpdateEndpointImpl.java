package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.endpoint.AddEndpointRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;

@Component
@RequiredArgsConstructor
public class UpdateEndpointImpl implements UpdateEndpoint {

    private final GetEndpoint getEndpoint;
    private final EndpointRepository endpointRepository;
    private final AddEndpointRequestBodyMapper addEndpointRequestBodyMapper;

    @Override
    public Endpoint execute(
            AddEndpointRequestBody addEndpointRequestBody,
            Long endpointId
    ) {
        final var endpoint = getEndpoint.execute(endpointId);

        addEndpointRequestBodyMapper.updateEndpoint(addEndpointRequestBody, endpoint);

        return endpointRepository.save(endpoint);
    }
}
