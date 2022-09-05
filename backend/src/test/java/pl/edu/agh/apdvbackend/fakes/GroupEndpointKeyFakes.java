package pl.edu.agh.apdvbackend.fakes;

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
}
