package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.endpoint.EndpointResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllEndpointSummariesImpl implements GetAllEndpointSummaries {

    private final EndpointRepository endpointRepository;
    private final ListUtilities listUtilities;
    private final EndpointResponseBodyMapper mapper;

    @Override
    public List<EndpointResponseBody> execute() {
        final var endpointList = listUtilities.iterableToList(endpointRepository.findAll());
        return mapper.toResponseBodyList(endpointList);
    }
}
