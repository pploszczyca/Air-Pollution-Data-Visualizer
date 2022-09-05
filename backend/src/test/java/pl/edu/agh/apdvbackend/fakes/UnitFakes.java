package pl.edu.agh.apdvbackend.fakes;

import java.util.Collections;
import pl.edu.agh.apdvbackend.models.database.Unit;

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
}
