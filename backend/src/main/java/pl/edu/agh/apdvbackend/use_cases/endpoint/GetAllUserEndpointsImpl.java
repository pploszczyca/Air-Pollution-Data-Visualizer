package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.EndpointMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllUserEndpointsImpl
        implements GetAllUserEndpoints {

    private final EndpointRepository endpointRepository;

    private final ListUtilities listUtilities;

    private final EndpointMapper endpointMapper;

    @Override
    public List<UserEndpointResponseBody> execute(Long userId) {
        final var endpoints = listUtilities.iterableToList(
                endpointRepository.findAllThatBelongToUser(userId));

        return endpointMapper.endpointListToUserEndpointResponseBodyList(
                endpoints);
    }
}
