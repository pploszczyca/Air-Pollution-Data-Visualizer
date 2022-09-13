package pl.edu.agh.apdvbackend.models.database;

import io.swagger.v3.oas.annotations.media.Schema;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "unit_converter")
@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class UnitConverter {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    @ManyToOne
    @JoinColumn(name = "from_unit_id")
    private Unit fromUnit;

    @Schema(required = true)
    @ManyToOne
    @JoinColumn(name = "to_unit_id")
    private Unit toUnit;

    @Schema(required = true, description =
            "Some operations need more than one math operation " +
                    "(like conversion from Celsius to Fahrenheit), so this variable specify step number.")
    private int calculationStep;

    @Schema(required = true)
    @Enumerated(EnumType.ORDINAL)
    private MathOperation mathOperation;

    @Schema(required = true)
    private Double value;
}
