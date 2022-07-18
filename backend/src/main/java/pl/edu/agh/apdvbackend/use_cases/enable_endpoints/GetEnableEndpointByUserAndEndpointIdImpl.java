package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.EnableEndpointsForGroup;
import pl.edu.agh.apdvbackend.repositories.EnableEndpointsForGroupRepository;

@Component
@RequiredArgsConstructor
public class GetEnableEndpointByUserAndEndpointIdImpl
        implements GetEnableEndpointByUserAndEndpointId {

    private final EnableEndpointsForGroupRepository
            enableEndpointsForGroupRepository;

    @Override
    public EnableEndpointsForGroup execute(Long userId, Long endpointId) {
        return enableEndpointsForGroupRepository
                .findByUserIdAndEndpointId(userId, endpointId)
                .orElseThrow();
    }
}
