package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import java.util.List;
import lombok.RequiredArgsConstructor;
import pl.edu.agh.apdvbackend.models.EnableEndpointsForGroup;
import pl.edu.agh.apdvbackend.repositories.EnableEndpointsForGroupRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@RequiredArgsConstructor
public class GetEnableEndpointsByGroupIdImpl
        implements GetEnableEndpointsByGroupId {

    private final EnableEndpointsForGroupRepository
            enableEndpointsForGroupRepository;

    private final ListUtilities listUtilities;

    @Override
    public List<EnableEndpointsForGroup> execute(Long groupId) {
        return listUtilities.iterableToList(
                enableEndpointsForGroupRepository.findAllByGroupId(groupId));
    }
}
