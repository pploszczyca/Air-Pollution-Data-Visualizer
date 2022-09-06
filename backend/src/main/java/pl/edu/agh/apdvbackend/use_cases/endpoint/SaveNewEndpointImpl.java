package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.endpoint.EndpointRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;

@Component
@RequiredArgsConstructor
public class SaveNewEndpointImpl implements SaveNewEndpoint {

    private final EndpointRequestBodyMapper endpointRequestBodyMapper;
    private final EndpointRepository endpointRepository;

    @Override
    public Endpoint execute(EndpointRequestBody endpointRequestBody) {
        return endpointRepository.save(
                endpointRequestBodyMapper.toEndpoint(endpointRequestBody)
        );
    }
}
