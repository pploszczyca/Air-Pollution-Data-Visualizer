package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import java.util.List;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;
import pl.edu.agh.apdvbackend.models.database.GroupEndpointKey;

public class GroupEndpointFakes {

    public static final int DETAILED_MEASUREMENT_DAYS = 999;
    public static final int APPROXIMATION_PRECISSION = 9999;

    public static GroupEndpoint getGroupEndpoint() {
        final var groupEndpoint = new GroupEndpoint();
        groupEndpoint.setId(GroupEndpointKeyFakes.getGroupEndpointKey());
        groupEndpoint.setGroup(GroupFakes.getGroup());
        groupEndpoint.setEndpoint(EndpointFakes.getEndpoint());
        groupEndpoint.setEnableFields(Collections.emptyList());
        groupEndpoint.setDetailedMeasurementDays(DETAILED_MEASUREMENT_DAYS);
        groupEndpoint.setApproximationPrecission(APPROXIMATION_PRECISSION);

        return groupEndpoint;
    }

    @Builder
    private static GroupEndpoint buildNewGroupEndpoint(
            GroupEndpointKey id,
            Group group,
            Endpoint endpoint,
            List<Field> enableFields,
            Integer detailedMeasurementDays,
            Integer approximationPrecission
    ) {
        final var groupEndpoint = new GroupEndpoint();
        groupEndpoint.setId(getOrElse(id, GroupEndpointKeyFakes.getGroupEndpointKey()));
        groupEndpoint.setGroup(getOrElse(group, GroupFakes.getGroup()));
        groupEndpoint.setEndpoint(getOrElse(endpoint, EndpointFakes.getEndpoint()));
        groupEndpoint.setEnableFields(getOrElse(enableFields, Collections.emptyList()));
        groupEndpoint.setDetailedMeasurementDays(getOrElse(detailedMeasurementDays, DETAILED_MEASUREMENT_DAYS));
        groupEndpoint.setApproximationPrecission(getOrElse(approximationPrecission, APPROXIMATION_PRECISSION));

        return groupEndpoint;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
