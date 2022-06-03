package pl.edu.agh.apdvbackend.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.Iterator;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.deserializer.EndpointDeserializer;
import pl.edu.agh.apdvbackend.models.Endpoint;
import pl.edu.agh.apdvbackend.models.Field;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.use_cases.datahub.GetJsonNodeFromDataHub;
import pl.edu.agh.apdvbackend.use_cases.enable_endpoints.GetEnableEndpointByGroupAndEndpointIds;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetAllEndpoints;
import pl.edu.agh.apdvbackend.use_cases.endpoint.RemoveEndpointById;
import pl.edu.agh.apdvbackend.use_cases.endpoint.SaveNewEndpoint;
import pl.edu.agh.apdvbackend.utilities.StreamUtilities;

@Service
@RequiredArgsConstructor
public class EndpointService {
    private final StreamUtilities streamUtilities;

    private final GetJsonNodeFromDataHub getJsonNodeFromDataHub;

    private final EndpointDeserializer endpointDeserializer;

    private final GetEnableEndpointByGroupAndEndpointIds
            getEnableEndpointByGroupAndEndpointIds;

    private final SaveNewEndpoint saveNewEndpoint;

    private final RemoveEndpointById removeEndpointById;

    private final GetAllEndpoints getAllEndpoints;

    public Response<List<ObjectNode>> getWeatherData(Long groupId,
                                                     Long sensorId) {
        try {
            final var enableEndpoints =
                    getEnableEndpointByGroupAndEndpointIds.execute(groupId,
                            sensorId);
            final var endpoint = enableEndpoints.getEndpoint();
            final var rawEndpointData =
                    getJsonNodeFromDataHub.execute(endpoint.getSensorUrl());
            final var result = parseWeatherData(rawEndpointData, endpoint,
                    enableEndpoints.getEnableFields());

            return Response.withOkStatus(result);
        } catch (Exception exception) {
            return Response.withError(exception.getMessage());
        }
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

    public Response<List<Endpoint>> getEndpointsList() {
        return Response.withOkStatus(getAllEndpoints.execute());
    }

    public Endpoint addEndpoint(
            AddEndpointRequestBody addEndpointRequestBody) {
        return saveNewEndpoint.execute(addEndpointRequestBody);
    }

    public void removeEndpoint(Long endpointId) {
        removeEndpointById.execute(endpointId);
    }
}
