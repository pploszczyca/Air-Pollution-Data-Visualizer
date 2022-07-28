package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;
import pl.edu.agh.apdvbackend.repositories.GroupRepositoryRepository;

@Component
@RequiredArgsConstructor
public class GetEnableEndpointByUserAndEndpointIdImpl
        implements GetEnableEndpointByUserAndEndpointId {

    private final GroupRepositoryRepository
            groupRepositoryRepository;

    @Override
    public GroupEndpoint execute(Long userId, Long endpointId) {
        return groupRepositoryRepository
                .findByUserIdAndEndpointId(userId, endpointId)
                .orElseThrow();
    }
}
