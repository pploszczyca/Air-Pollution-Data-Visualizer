package pl.edu.agh.apdvbackend.models.database;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "field_parser")
@Getter
@Setter
@NoArgsConstructor
public class FieldParser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    @Column(unique = true)
    private String path;

    @JsonIgnore
    @ManyToMany(mappedBy = "fieldParserMap")
    private List<Endpoint> endpoints;
}
