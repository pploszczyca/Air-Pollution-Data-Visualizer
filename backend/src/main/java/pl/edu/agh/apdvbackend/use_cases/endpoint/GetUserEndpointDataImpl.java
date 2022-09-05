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
import pl.edu.agh.apdvbackend.use_cases.group_endpoint.GetEndpointDataForUser;
import pl.edu.agh.apdvbackend.utilities.StreamUtilities;

@Component
@RequiredArgsConstructor
public class GetUserEndpointDataImpl implements GetUserEndpointData {

    private final StreamUtilities streamUtilities;
    private final EndpointDeserializer endpointDeserializer;
    private final GetJsonNodeFromDataHub getJsonNodeFromDataHub;
    private final GetEndpoint getEndpoint;
    private final GetEndpointDataForUser getEndpointDataForUser;

    @Override
    public List<ObjectNode> execute(
            Long userId,
            Long endpointId,
            Long limit,
            Long offset
    ) {
        final var fields = getEndpointDataForUser
                .execute(userId, endpointId)
                .enableFields();
        final var endpoint = getEndpoint
                .execute(endpointId);
        final var rawEndpointData = getJsonNodeFromDataHub
                .execute(endpoint.getSensorUrl(), limit, offset);

        return parseWeatherData(rawEndpointData, endpoint, fields);
    }

    private List<ObjectNode> parseWeatherData(
            Iterator<JsonNode> dataIterator,
            Endpoint endpoint,
            List<Field> enableFields
    ) {
        return streamUtilities.asStream(
                dataIterator
        ).map(jsonNode -> endpointDeserializer.deserialize(
                jsonNode,
                endpoint,
                enableFields)
        ).toList();
    }
}
