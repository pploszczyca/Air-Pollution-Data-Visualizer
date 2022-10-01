package pl.edu.agh.apdvbackend.fakes.body_models.endpoint;

import java.util.Collections;
import java.util.List;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Field;

public class GroupEndpointResponseBodyFakes {

    private static final int ENDPOINT_NUMBER = 99;

    @Builder
    private static GroupEndpointResponseBody buildNewGroupEndpointResponseBody(
            Long id,
            String label,
            int endpointNumber,
            List<Field> enableFields
    ) {
        return new GroupEndpointResponseBody(
                id,
                getOrElse(label, "dummy label"),
                getOrElse(endpointNumber, ENDPOINT_NUMBER),
                getOrElse(enableFields, Collections.emptyList())
        );
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
