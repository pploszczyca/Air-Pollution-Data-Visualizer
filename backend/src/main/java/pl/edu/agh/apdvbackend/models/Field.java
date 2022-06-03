package pl.edu.agh.apdvbackend.models;

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
@Table(name = "field")
@Getter
@Setter
@NoArgsConstructor
public class Field {
    @Id
    @GeneratedValue
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    private String label;

    @ManyToMany(mappedBy = "enableFields")
    private List<EnableEndpointsForGroup> enableEndpointsForGroup;
}
