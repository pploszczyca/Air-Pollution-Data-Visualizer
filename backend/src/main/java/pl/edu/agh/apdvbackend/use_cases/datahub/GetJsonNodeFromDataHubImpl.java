package pl.edu.agh.apdvbackend.use_cases.datahub;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.Iterator;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

@Component
@RequiredArgsConstructor
public class GetJsonNodeFromDataHubImpl
        implements GetJsonNodeFromDataHub {

    private static final String RESULTS = "results";

    private final WebClient webClient;

    @Override
    public Iterator<JsonNode> execute(String uri) {
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
}
