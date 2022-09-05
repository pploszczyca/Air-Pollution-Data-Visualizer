package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

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
}
