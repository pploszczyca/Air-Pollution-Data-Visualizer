package pl.edu.agh.apdvbackend.deserializer;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.Endpoint;
import pl.edu.agh.apdvbackend.models.Field;

@Component
@RequiredArgsConstructor
public class EndpointDeserializerImpl
        implements EndpointDeserializer {

    private final ObjectMapper objectMapper;

    @Override
    public ObjectNode deserialize(JsonNode inputJsonNode,
                                  Endpoint endpoint,
                                  List<Field> requiredFields) {
        final var resultObjectNode = objectMapper.createObjectNode();

        requiredFields.forEach(field -> {
            final var path = endpoint.getFieldPath(field);
            resultObjectNode.set(field.getLabel(), inputJsonNode.at(path));
        });

        return resultObjectNode;
    }

}
