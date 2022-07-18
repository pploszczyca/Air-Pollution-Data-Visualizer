package pl.edu.agh.apdvbackend.models.database;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EnableEndpointsForGroupKey implements Serializable {

    @Column(name = "group_id")
    private Long groupId;

    @Column(name = "endpoint_id")
    private Long endpointId;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final EnableEndpointsForGroupKey that = (EnableEndpointsForGroupKey) o;
        return groupId.equals(that.groupId) &&
                endpointId.equals(that.endpointId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(groupId, endpointId);
    }
}
