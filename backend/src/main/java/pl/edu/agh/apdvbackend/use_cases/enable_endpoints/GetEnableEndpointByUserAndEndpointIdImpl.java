package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;
import pl.edu.agh.apdvbackend.repositories.GroupEndpointRepository;

@Component
@RequiredArgsConstructor
public class GetEnableEndpointByUserAndEndpointIdImpl
        implements GetEnableEndpointByUserAndEndpointId {

    private final GroupEndpointRepository
            groupEndpointRepository;

    @Override
    public GroupEndpoint execute(Long userId, Long endpointId) {
        return groupEndpointRepository
                .findByUserIdAndEndpointId(userId, endpointId)
                .orElseThrow();
    }
}
