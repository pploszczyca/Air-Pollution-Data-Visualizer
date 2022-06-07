package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.mappers.EndpointMapper;
import pl.edu.agh.apdvbackend.models.Endpoint;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;

@Component
@RequiredArgsConstructor
public class UpdateEndpointImpl
        implements UpdateEndpoint {

    private final GetEndpoint getEndpoint;

    private final EndpointRepository endpointRepository;

    private final EndpointMapper endpointMapper;

    @Override
    public Endpoint execute(AddEndpointRequestBody addEndpointRequestBody,
                            Long endpointId) {
        final var endpoint = getEndpoint.execute(endpointId);

        endpointMapper.updateEndpointFromAddRequestBody(addEndpointRequestBody, endpoint);

        return endpointRepository.save(endpoint);
    }
}
