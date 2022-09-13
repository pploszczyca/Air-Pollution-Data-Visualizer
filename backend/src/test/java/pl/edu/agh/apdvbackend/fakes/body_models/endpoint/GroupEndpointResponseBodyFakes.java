package pl.edu.agh.apdvbackend.fakes.body_models.endpoint;

import java.util.Collections;
import java.util.List;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.GroupEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Field;

public class GroupEndpointResponseBodyFakes {

    private static final int ENDPOINT_NUMBER = 99;
    private static final int DEFAULT_DETAILED_MEASURED_DAYS = 999;
    private static final int DEFAULT_APPROXIMATION_PRECISSION = 9999;

    @Builder
    private static GroupEndpointResponseBody buildNewGroupEndpointResponseBody(
            Long id,
            String label,
            int endpointNumber,
            List<Field> enableFields,
            Integer detailedMeasurementDays,
            Integer approximationPrecission
    ) {
        return new GroupEndpointResponseBody(
                id,
                getOrElse(label, "dummy label"),
                getOrElse(endpointNumber, ENDPOINT_NUMBER),
                getOrElse(enableFields, Collections.emptyList()),
                getOrElse(detailedMeasurementDays, DEFAULT_DETAILED_MEASURED_DAYS),
                getOrElse(approximationPrecission, DEFAULT_APPROXIMATION_PRECISSION)
        );
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
