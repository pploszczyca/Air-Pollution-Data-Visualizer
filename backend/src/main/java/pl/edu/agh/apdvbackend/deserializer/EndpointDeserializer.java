package pl.edu.agh.apdvbackend.deserializer;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.List;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;

public interface EndpointDeserializer {
    ObjectNode deserialize(
            JsonNode inputJsonNode,
            Endpoint endpoint,
            List<Field> requiredFields
    );
}
