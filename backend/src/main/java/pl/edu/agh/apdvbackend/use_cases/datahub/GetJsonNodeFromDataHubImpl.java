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

    private static final String LIMIT = "limit";

    private static final String OFFSET = "offset";

    private static final String RESULTS = "results";

    private final WebClient webClient;

    @Override
    public Iterator<JsonNode> execute(String uri, Long limit, Long offset) {
        return makeRequest(uri, limit, offset)
                .get(RESULTS)
                .iterator();
    }

    private ObjectNode makeRequest(String uri, Long limit, Long offset) {
        return webClient
                .get()
                .uri(uriBuilder -> uriBuilder
                        .path(uri)
                        .queryParam(LIMIT, limit)
                        .queryParam(OFFSET, offset)
                        .build())
                .retrieve()
                .bodyToMono(ObjectNode.class)
                .block();
    }
}
