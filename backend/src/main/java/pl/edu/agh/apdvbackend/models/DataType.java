package pl.edu.agh.apdvbackend.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "data_type")
@Getter
@Setter
@NoArgsConstructor
@JsonIgnoreProperties("endpointInfos")
public class DataType {
    @Id
    @GeneratedValue
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    private String label;

    @ManyToMany(mappedBy = "enableDataTypes")
    private List<EnableEndpointsForGroup> enableEndpointsForGroup;
}
