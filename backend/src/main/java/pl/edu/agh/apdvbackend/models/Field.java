package pl.edu.agh.apdvbackend.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "field")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties({"enableEndpointsForGroup"})
public class Field {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    private String label;

    @ManyToMany(mappedBy = "enableFields")
    private List<EnableEndpointsForGroup> enableEndpointsForGroup;
}
