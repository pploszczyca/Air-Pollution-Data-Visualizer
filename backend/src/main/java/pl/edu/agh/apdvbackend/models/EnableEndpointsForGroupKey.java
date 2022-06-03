package pl.edu.agh.apdvbackend.models;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
public class EnableEndpointsForGroupKey implements Serializable {

    @Column(name = "group_id")
    private Long groupId;

    @Column(name = "endpoint_info_id")
    private Long endpointInfoId;
}
