package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import java.util.List;
import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.Unit;
import pl.edu.agh.apdvbackend.models.database.UnitConverter;

public class UnitFakes {

    public static final long UNIT_ID = 9999L;

    public static Unit getUnit() {
        final var unit = new Unit();
        unit.setId(UNIT_ID);
        unit.setName("dummy unit name");
        unit.setFields(Collections.emptyList());
        unit.setFromUnitConverters(Collections.emptyList());
        unit.setToUnitConverters(Collections.emptyList());

        return unit;
    }

    @Builder
    private static Unit buildNewUnit(
            Long id,
            String name,
            List<Field> fields,
            List<UnitConverter> fromUnitConverters,
            List<UnitConverter> toUnitConverters
    ) {
        final var unit = new Unit();
        unit.setId(id);
        unit.setName(name);
        unit.setFields(fields);
        unit.setFromUnitConverters(fromUnitConverters);
        unit.setToUnitConverters(toUnitConverters);

        return unit;
    }
}
