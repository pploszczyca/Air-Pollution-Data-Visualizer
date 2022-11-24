package pl.edu.agh.apdvbackend.fakes;

import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.MathOperation;
import pl.edu.agh.apdvbackend.models.database.Unit;
import pl.edu.agh.apdvbackend.models.database.UnitConverter;

public class UnitConverterFakes {

    private static final int DEFAULT_CALCULATION_STEP = 99;
    private static final double DEFAULT_VALUE = 999.2;

    @Builder
    public static UnitConverter buildNewUnitConverter(
            Long id,
            Unit fromUnit,
            Unit toUnit,
            int calculationStep,
            MathOperation mathOperation,
            Double value
    ) {
        final var unitConverter = new UnitConverter();
        unitConverter.setId(id);
        unitConverter.setFromUnit(getOrElse(fromUnit, UnitFakes.builder().build()));
        unitConverter.setToUnit(getOrElse(toUnit, UnitFakes.builder().build()));
        unitConverter.setCalculationStep(getOrElse(calculationStep, DEFAULT_CALCULATION_STEP));
        unitConverter.setMathOperation(getOrElse(mathOperation, MathOperation.ADDITION));
        unitConverter.setValue(getOrElse(value, DEFAULT_VALUE));

        return unitConverter;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
