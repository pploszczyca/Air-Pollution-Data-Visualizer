package pl.edu.agh.apdvbackend.use_cases.endpoint;

import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.List;

public interface GetUserEndpointData {
    List<ObjectNode> execute(Long userId, Long endpointId, Long limit, Long offset);
}
