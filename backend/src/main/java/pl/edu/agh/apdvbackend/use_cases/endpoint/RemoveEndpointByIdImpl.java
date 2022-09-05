package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;

@Component
@RequiredArgsConstructor
public class RemoveEndpointByIdImpl implements RemoveEndpointById {

    private final EndpointRepository endpointRepository;

    @Override
    public void execute(Long endpointId) {
        endpointRepository.deleteById(endpointId);
    }
}
