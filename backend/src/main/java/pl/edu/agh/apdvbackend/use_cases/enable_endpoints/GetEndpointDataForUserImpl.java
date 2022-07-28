package pl.edu.agh.apdvbackend.use_cases.enable_endpoints;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.GroupEndpointMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;
import pl.edu.agh.apdvbackend.repositories.GroupEndpointRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetEndpointDataForUserImpl
        implements GetEndpointDataForUser {

    private final GroupEndpointRepository groupEndpointRepository;

    private final ListUtilities listUtilities;

    private final GroupEndpointMapper groupEndpointMapper;

    @Override
    public GroupEndpointResponseBody execute(Long userId, Long endpointId) {
        final var groupEndpoints =
                listUtilities.iterableToList(
                        groupEndpointRepository.findAllUserIdAndEndpointId(
                                userId,
                                endpointId));

        return groupEndpointMapper.mapToResponseBody(groupEndpoints);
    }

}
