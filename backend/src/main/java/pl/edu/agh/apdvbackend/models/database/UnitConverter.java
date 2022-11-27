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
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "unit_converter")
@Getter
@Setter
@NoArgsConstructor
public class UnitConverter {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    private Long id;

    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    @ManyToOne
    @JoinColumn(name = "from_unit_id")
    private Unit fromUnit;

    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    @ManyToOne
    @JoinColumn(name = "to_unit_id")
    private Unit toUnit;

    @Schema(requiredMode = Schema.RequiredMode.REQUIRED, description =
            "Some operations need more than one math operation " +
                    "(like conversion from Celsius to Fahrenheit), so this variable specify step number.")
    private int calculationStep;

    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    @Enumerated(EnumType.ORDINAL)
    private MathOperation mathOperation;

    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    private Double value;
}
