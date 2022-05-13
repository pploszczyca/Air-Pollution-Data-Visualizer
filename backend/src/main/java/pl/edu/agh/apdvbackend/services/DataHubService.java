package pl.edu.agh.apdvbackend.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import pl.edu.agh.apdvbackend.deserializer.DataDeserializer;
import pl.edu.agh.apdvbackend.models.DataResponse;
import pl.edu.agh.apdvbackend.models.DataTypes;
import pl.edu.agh.apdvbackend.utilities.StreamUtilities;

import java.util.Iterator;

@Service
public class DataHubService {
    private final WebClient webClient;
    private final StreamUtilities streamUtilities;
    private final DataDeserializer dataDeserializer;

    @Autowired
    public DataHubService(WebClient webClient,
                          StreamUtilities streamUtilities,
                          DataDeserializer dataDeserializer) {
        this.webClient = webClient;
        this.streamUtilities = streamUtilities;
        this.dataDeserializer = dataDeserializer;
    }

    public ResponseEntity<?> getData() {
        return ResponseEntity.ok(
                streamUtilities.asStream(
                        makeRequestAndGetResults("/pl/datasets/dyplomy-2022/endpoints/96/data/?limit=25")
                ).map(jsonNode -> new DataResponse(
                        dataDeserializer.getDoubleValue(DataTypes.TEMPERATURE, jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.PRESSURE, jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.HUMIDITY, jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.PM1_0, jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.PM2_5, jsonNode),
                        dataDeserializer.getDoubleValue(DataTypes.PM10, jsonNode)
                ))

        );
    }

    private Iterator<JsonNode> makeRequestAndGetResults(String uri) {
        return makeRequest(uri)
                .get("results")
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
}
