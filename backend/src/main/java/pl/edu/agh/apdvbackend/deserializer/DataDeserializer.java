package pl.edu.agh.apdvbackend.deserializer;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.DataTypes;

import java.util.List;
import java.util.Map;

@Component
public class DataDeserializer {
    private final Map<DataTypes, List<String>> valuesMap;

    @Autowired
    public DataDeserializer(@Qualifier("dataDeserializerMap") Map<DataTypes, List<String>> valuesMap) {
        this.valuesMap = valuesMap;
    }

    public JsonNode getKeyNode(DataTypes dataType, JsonNode jsonNode) {
        List<String> path = valuesMap.get(dataType);
        JsonNode node = jsonNode;

        for(String s: path) {
            node = node.get(s);
        }

        return node;
    }

    public double getDoubleValue(DataTypes dataType, JsonNode jsonNode) {
        return getKeyNode(dataType, jsonNode).asDouble();
    }
}
