package pl.edu.agh.apdvbackend.deserializer;

import com.fasterxml.jackson.databind.JsonNode;

public interface DataDeserializer {
    double getDoubleValue(String dataType, JsonNode jsonNode);

    String getStringValue(String dataType, JsonNode jsonNode);
}
