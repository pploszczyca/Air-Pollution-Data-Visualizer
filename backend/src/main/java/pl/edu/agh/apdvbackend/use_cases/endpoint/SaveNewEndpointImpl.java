package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.EndpointMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;

@Component
@RequiredArgsConstructor
public class SaveNewEndpointImpl implements SaveNewEndpoint {

    private final EndpointMapper endpointMapper;
    private final EndpointRepository endpointRepository;

    @Override
    public Endpoint execute(AddEndpointRequestBody addEndpointRequestBody) {
        return endpointRepository.save(
                endpointMapper.fromAddRequestBodyToEndpointInfo(addEndpointRequestBody)
        );
    }
}
