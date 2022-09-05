package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;

@Component
@RequiredArgsConstructor
public class GetEndpointImpl implements GetEndpoint {

    private final EndpointRepository endpointRepository;

    @Override
    public Endpoint execute(Long endpointId) {
        return endpointRepository
                .findById(endpointId)
                .orElseThrow();
    }
}
