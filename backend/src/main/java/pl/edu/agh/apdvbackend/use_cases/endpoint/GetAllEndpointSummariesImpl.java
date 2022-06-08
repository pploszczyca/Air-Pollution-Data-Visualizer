package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.EndpointSummaryResponseBody;
import pl.edu.agh.apdvbackend.mappers.EndpointMapper;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllEndpointSummariesImpl
        implements GetAllEndpointSummaries {

    private final EndpointRepository endpointRepository;

    private final ListUtilities listUtilities;

    private final EndpointMapper endpointMapper;

    @Override
    public List<EndpointSummaryResponseBody> execute() {
        final var endpointList =
                listUtilities.iterableToList(endpointRepository.findAll());
        return endpointMapper.endpointListToSummaryResponseBodyList(
                endpointList);
    }
}
