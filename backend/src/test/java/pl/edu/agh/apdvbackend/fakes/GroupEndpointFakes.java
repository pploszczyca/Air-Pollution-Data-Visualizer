package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

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
}
