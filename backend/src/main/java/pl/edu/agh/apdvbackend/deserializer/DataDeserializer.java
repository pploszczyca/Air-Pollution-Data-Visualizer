package pl.edu.agh.apdvbackend.deserializer;

import com.fasterxml.jackson.databind.JsonNode;
import pl.edu.agh.apdvbackend.models.DataTypes;

public interface DataDeserializer {
    double getDoubleValue(DataTypes dataType, JsonNode jsonNode);

    String getStringValue(DataTypes dataType, JsonNode jsonNode);
}
