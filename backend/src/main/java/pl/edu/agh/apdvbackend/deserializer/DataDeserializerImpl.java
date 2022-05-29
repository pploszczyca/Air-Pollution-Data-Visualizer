package pl.edu.agh.apdvbackend.deserializer;

import com.fasterxml.jackson.databind.JsonNode;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class DataDeserializerImpl implements DataDeserializer {
    private final Map<String, List<String>> valuesMap;

    @Autowired
    public DataDeserializerImpl(@Qualifier("dataDeserializerMap")
                                Map<String, List<String>> valuesMap) {
        this.valuesMap = valuesMap;
    }

    private JsonNode getKeyNode(String dataType, JsonNode jsonNode) {
        final List<String> path = valuesMap.get(dataType);
        JsonNode node = jsonNode;

        for (String s : path) {
            node = node.get(s);
        }

        return node;
    }

    @Override
    public double getDoubleValue(String dataType, JsonNode jsonNode) {
        return getKeyNode(dataType, jsonNode).asDouble();
    }

    @Override
    public String getStringValue(String dataType, JsonNode jsonNode) {
        return getKeyNode(dataType, jsonNode).asText();
    }
}
