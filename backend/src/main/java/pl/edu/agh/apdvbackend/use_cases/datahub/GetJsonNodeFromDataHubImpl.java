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

    private static final int STANDARD_LIMIT = 25;

    private static final int STANDARD_OFFSET = 0;

    private final WebClient webClient;

    @Override
    public Iterator<JsonNode> execute(String uri) {
        return execute(uri, STANDARD_LIMIT, STANDARD_OFFSET);
    }

    @Override
    public Iterator<JsonNode> execute(String uri, int limit, int offset) {
        return makeRequest(uri, limit, offset)
                .get(RESULTS)
                .iterator();
    }


    private ObjectNode makeRequest(String uri, int limit, int offset) {
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
