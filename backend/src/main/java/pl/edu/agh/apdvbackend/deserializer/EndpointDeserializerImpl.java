package pl.edu.agh.apdvbackend.deserializer;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.exceptions.IncorrectNodeDeserialize;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;

@Component
@RequiredArgsConstructor
public class EndpointDeserializerImpl
        implements EndpointDeserializer {

    private final ObjectMapper objectMapper;

    @Override
    public ObjectNode deserialize(
            JsonNode inputJsonNode,
            Endpoint endpoint,
            List<Field> requiredFields
    ) {
        final var resultObjectNode = objectMapper.createObjectNode();

        requiredFields.forEach(field -> {
            final var path = endpoint.getFieldPath(field);
            final var node = inputJsonNode.at(path);

            checkIfNodeDataIsProper(node, field.getLabel());

            resultObjectNode.set(field.getLabel(), node);
        });

        return resultObjectNode;
    }

    @SneakyThrows
    private void checkIfNodeDataIsProper(JsonNode jsonNode, String label) {
        if (jsonNode.isMissingNode()) {
            throw new IncorrectNodeDeserialize(label);
        }
    }
}
