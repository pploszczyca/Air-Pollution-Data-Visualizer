package pl.edu.agh.apdvbackend.use_cases.datahub;

import com.fasterxml.jackson.databind.JsonNode;
import java.util.Iterator;

public interface GetJsonNodeFromDataHub {
    Iterator<JsonNode> execute(String uri);
}
