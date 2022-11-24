package pl.edu.agh.apdvbackend.fakes;

import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.GroupEndpointKey;

public class GroupEndpointKeyFakes {

    public static final long ENDPOINT_ID = 9L;
    public static final long GROUP_ID = 1111L;

    public static GroupEndpointKey getGroupEndpointKey() {
        final var groupEndpointKey = new GroupEndpointKey();
        groupEndpointKey.setEndpointId(ENDPOINT_ID);
        groupEndpointKey.setGroupId(GROUP_ID);

        return groupEndpointKey;
    }

    @Builder
    private static GroupEndpointKey buildNewGroupEndpointKey(
            Long endpointId,
            Long groupId
    ) {
        final var groupEndpointKey = new GroupEndpointKey();
        groupEndpointKey.setEndpointId(getOrElse(endpointId ,ENDPOINT_ID));
        groupEndpointKey.setGroupId(getOrElse(groupId ,GROUP_ID));

        return groupEndpointKey;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
