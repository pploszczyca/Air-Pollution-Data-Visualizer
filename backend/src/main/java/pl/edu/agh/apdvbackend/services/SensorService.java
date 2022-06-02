package pl.edu.agh.apdvbackend.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import pl.edu.agh.apdvbackend.deserializer.DataDeserializer;
import pl.edu.agh.apdvbackend.mappers.EndpointInfoMapper;
import pl.edu.agh.apdvbackend.models.DataTypes;
import pl.edu.agh.apdvbackend.models.EndpointInfo;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.Endpoint;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.EndpointData;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;
import pl.edu.agh.apdvbackend.utilities.StreamUtilities;

@Service
public class SensorService {
    private static final String RESULTS = "results";

    private final WebClient webClient;

    private final StreamUtilities streamUtilities;

    private final DataDeserializer dataDeserializer;

    private final EndpointRepository endpointRepository;

    private final ListUtilities listUtilities;

    private final EndpointInfoMapper endpointInfoMapper;

    @Autowired
    public SensorService(WebClient webClient,
                         StreamUtilities streamUtilities,
                         DataDeserializer dataDeserializer,
                         EndpointRepository endpointRepository,
                         ListUtilities listUtilities,
                         EndpointInfoMapper endpointInfoMapper) {
        this.webClient = webClient;
        this.streamUtilities = streamUtilities;
        this.dataDeserializer = dataDeserializer;
        this.endpointRepository = endpointRepository;
        this.listUtilities = listUtilities;
        this.endpointInfoMapper = endpointInfoMapper;
    }

    public Response<Endpoint> getWeatherData(Long sensorId) {
        try {
            final var endpoint =
                    endpointRepository.findById(sensorId).orElseThrow();
            final var endpointData = parseWeatherData(
                    makeRequestAndGetResults(endpoint.getSensorUrl()));
            return Response.withOkStatus(
                    new Endpoint(sensorId, endpoint.getLabel(), endpointData));
        } catch (Exception exception) {
            return Response.withError(exception.getMessage());
        }
    }

    private List<EndpointData> parseWeatherData(
            Iterator<JsonNode> dataIterator) {
        return streamUtilities.asStream(
                dataIterator
        ).map(jsonNode -> new EndpointData(
                        dataDeserializer.getDoubleValue(DataTypes.TEMPERATURE.name(),
                                jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.PRESSURE.name(), jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.HUMIDITY.name(), jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.PM1_0.name(), jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.PM2_5.name(), jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.PM10.name(), jsonNode),
                        dataDeserializer.getStringValue(DataTypes.TIMESTAMP.name(), jsonNode)
                )
        ).toList();
    }

    private Iterator<JsonNode> makeRequestAndGetResults(String uri) {
        return makeRequest(uri)
                .get(RESULTS)
                .iterator();
    }

    private ObjectNode makeRequest(String uri) {
        return webClient
                .get()
                .uri(uri)
                .retrieve()
                .bodyToMono(ObjectNode.class)
                .block();
    }

    public Response<List<EndpointInfo>> getEndpointsList() {
        return Response.withOkStatus(
                listUtilities.iterableToList(endpointRepository.findAll()));
    }

    public EndpointInfo addEndpoint(
            AddEndpointRequestBody addEndpointRequestBody) {
        return endpointRepository.save(
                endpointInfoMapper.fromAddRequestBodyToEndpointInfo(
                        addEndpointRequestBody));
    }

    public void removeEndpoint(Long endpointId) {
        endpointRepository.deleteById(endpointId);
    }
}
