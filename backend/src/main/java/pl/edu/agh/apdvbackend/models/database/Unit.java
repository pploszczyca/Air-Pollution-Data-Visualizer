package pl.edu.agh.apdvbackend.models.database;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "unit")
@Getter
@Setter
@NoArgsConstructor
@JsonIgnoreProperties({"fields", "fromUnitConverters", "toUnitConverters"})
public class Unit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    @Column(unique = true)
    private String name;

    @OneToMany(mappedBy = "unit")
    private List<Field> fields;

    @OneToMany(mappedBy = "fromUnit")
    private List<UnitConverter> fromUnitConverters;

    @OneToMany(mappedBy = "toUnit")
    private List<UnitConverter> toUnitConverters;
}
