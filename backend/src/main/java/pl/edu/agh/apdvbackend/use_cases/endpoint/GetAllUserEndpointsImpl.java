package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.Endpoint;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllUserEndpointsImpl
        implements GetAllUserEndpoints {

    private final EndpointRepository endpointRepository;

    private final ListUtilities listUtilities;

    @Override
    public List<Endpoint> execute(Long userId) {
        return listUtilities.iterableToList(
                endpointRepository.findAllThatBelongToUser(userId));
    }
}
