package pl.edu.agh.apdvbackend.services;

import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

@Service
public class DataHubService {
    private final WebClient webClient;

    @Autowired
    public DataHubService(WebClient webClient) {
        this.webClient = webClient;
    }

    public ResponseEntity<?> getData() {
        return ResponseEntity.ok(webClient
                .get()
                .uri("/pl/datasets/dyplomy-2022/endpoints/96/data/?limit=25")
                .retrieve()
                .bodyToMono(ObjectNode.class)
                .block());
    }
}
