package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import java.util.Map;
import java.util.Set;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

public class EndpointFakes {

    public static final long ENDPOINT_ID = 99999L;
    public static final int ENDPOINT_NUMBER = 99;

    public static Endpoint getEndpoint() {
        final var endpoint = new Endpoint();
        endpoint.setId(ENDPOINT_ID);
        endpoint.setEndpointNumber(ENDPOINT_NUMBER);
        endpoint.setLabel("dummy endpoint label");
        endpoint.setSensorUrl("dummy endpoint url");
        endpoint.setFieldParserMap(Collections.emptyMap());
        endpoint.setGroupEndpoints(Collections.emptySet());

        return endpoint;
    }

    @Builder
    private static Endpoint buildNewEndpoint(
            Long id,
            int endpointNumber,
            String label,
            String sensorUrl,
            Map<Field, FieldParser> fieldParserMap,
            Set<GroupEndpoint> groupEndpoints
    ) {
        final var endpoint = new Endpoint();
        endpoint.setId(id);
        endpoint.setEndpointNumber(getOrElse(endpointNumber, ENDPOINT_NUMBER));
        endpoint.setLabel(getOrElse(label, "dummy endpoint label"));
        endpoint.setSensorUrl(getOrElse(sensorUrl, "dummy endpoint url"));
        endpoint.setFieldParserMap(getOrElse(fieldParserMap, Collections.emptyMap()));
        endpoint.setGroupEndpoints(getOrElse(groupEndpoints, Collections.emptySet()));

        return endpoint;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
