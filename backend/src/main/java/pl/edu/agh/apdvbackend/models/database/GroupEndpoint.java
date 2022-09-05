package pl.edu.agh.apdvbackend.models.database;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "group_endpoint")
public class GroupEndpoint {
    @EmbeddedId
    private GroupEndpointKey id;

    @ManyToOne
    @MapsId("groupId")
    @JoinColumn(name = "group_id")
    private Group group;

    @ManyToOne
    @MapsId("endpointId")
    @JoinColumn(name = "endpoint_id")
    private Endpoint endpoint;

    @ManyToMany
    @JoinTable(
            name = "enable_fields",
            joinColumns = {@JoinColumn(name = "endpoint_id"),
                    @JoinColumn(name = "gropu_id")},
            inverseJoinColumns = {@JoinColumn(name = "field_id")}
    )
    private List<Field> enableFields = new ArrayList<>();

    private Integer detailedMeasurementDays;

    private Integer approximationPrecission;
}
