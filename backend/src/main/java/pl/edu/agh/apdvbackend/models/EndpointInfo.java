package pl.edu.agh.apdvbackend.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.Map;
import java.util.Set;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "endpoint_info")
@Getter
@Setter
@NoArgsConstructor
@JsonIgnoreProperties({"groups"})
public class EndpointInfo {
    @Id
    @GeneratedValue
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    private int endpointNumber;

    @Schema(required = true)
    private String label;

    @Schema(required = true)
    private String sensorUrl;

    @ManyToMany(mappedBy = "availableEndpoints")
    private Set<Group> groups;

    @ManyToMany
    @JoinTable
    private Set<DataType> dataTypes;
}
