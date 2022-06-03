package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.EnableEndpointsForGroup;
import pl.edu.agh.apdvbackend.repositories.EnableEndpointsForGroupRepository;

@Component
@RequiredArgsConstructor
public class GetEnableEndpointByGroupAndEndpointIdsImpl
        implements GetEnableEndpointByGroupAndEndpointIds {

    private final EnableEndpointsForGroupRepository
            enableEndpointsForGroupRepository;

    @Override
    public EnableEndpointsForGroup execute(Long groupId, Long endpointId) {
        return enableEndpointsForGroupRepository.findByGroupIdAndEndpointId(
                groupId, endpointId).orElseThrow();
    }
}
