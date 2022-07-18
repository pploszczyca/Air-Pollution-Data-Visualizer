package pl.edu.agh.apdvbackend.use_cases.endpoint;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.Iterator;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.deserializer.EndpointDeserializer;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.use_cases.datahub.GetJsonNodeFromDataHub;
import pl.edu.agh.apdvbackend.use_cases.enable_endpoints.GetEnableEndpointByUserAndEndpointId;
import pl.edu.agh.apdvbackend.utilities.StreamUtilities;

@Component
@RequiredArgsConstructor
public class GetUserEndpointDataImpl
        implements GetUserEndpointData {

    private final StreamUtilities streamUtilities;

    private final EndpointDeserializer endpointDeserializer;

    private final GetEnableEndpointByUserAndEndpointId
            getEnableEndpointByUserAndEndpointId;

    private final GetJsonNodeFromDataHub getJsonNodeFromDataHub;

    @Override
    public List<ObjectNode> execute(Long userId, Long endpointId, Long limit,
                                    Long offset) {
        final var enableEndpoint =
                getEnableEndpointByUserAndEndpointId.execute(userId,
                        endpointId);
        final var endpoint = enableEndpoint.getEndpoint();
        final var rawEndpointData =
                getJsonNodeFromDataHub.execute(endpoint.getSensorUrl(), limit,
                        offset);

        return parseWeatherData(rawEndpointData, endpoint,
                enableEndpoint.getEnableFields());
    }

    private List<ObjectNode> parseWeatherData(
            Iterator<JsonNode> dataIterator,
            Endpoint endpoint,
            List<Field> enableFields) {
        return streamUtilities.asStream(
                dataIterator
        ).map(jsonNode -> endpointDeserializer.deserialize(jsonNode, endpoint,
                enableFields)
        ).toList();
    }
}
