package pl.edu.agh.apdvbackend.mappers.unit;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.UnitConverterFakes;
import pl.edu.agh.apdvbackend.fakes.UnitFakes;
import pl.edu.agh.apdvbackend.mappers.unit_converter.UnitConverterResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.models.database.MathOperation;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class UnitConverterResponseBodyMapperTest {

    @Autowired
    private UnitConverterResponseBodyMapper mapper;

    @Test
    public void ShouldMapToResponseBody() {
        // Given
        final var id = 42L;
        final var fromUnitId = 54L;
        final var toUnitId = 69L;
        final var calculationStep = 10;
        final var mathOperation = MathOperation.DIVISION;
        final var value = 67.0;
        final var fromUnit = UnitFakes.builder()
                .id(fromUnitId)
                .build();
        final var toUnit = UnitFakes.builder()
                .id(toUnitId)
                .build();
        final var unit = UnitConverterFakes.builder()
                .id(id)
                .fromUnit(fromUnit)
                .toUnit(toUnit)
                .calculationStep(calculationStep)
                .mathOperation(mathOperation)
                .value(value)
                .build();
        final var expectedResult =
                new UnitConverterResponseBody(id, fromUnitId, toUnitId, calculationStep, mathOperation, value);

        // When
        final var result = mapper.toResponseBody(unit);

        // Then
        assertEquals(expectedResult, result);
    }

    @Test
    public void ShouldMapToResponseBodyList() {
        // Given
        final var id = 42L;
        final var fromUnitId = 54L;
        final var toUnitId = 69L;
        final var calculationStep = 10;
        final var mathOperation = MathOperation.DIVISION;
        final var value = 67.0;
        final var fromUnit = UnitFakes.builder()
                .id(fromUnitId)
                .build();
        final var toUnit = UnitFakes.builder()
                .id(toUnitId)
                .build();
        final var unit = UnitConverterFakes.builder()
                .id(id)
                .fromUnit(fromUnit)
                .toUnit(toUnit)
                .calculationStep(calculationStep)
                .mathOperation(mathOperation)
                .value(value)
                .build();
        final var expectedResult = List.of(
                new UnitConverterResponseBody(id, fromUnitId, toUnitId, calculationStep, mathOperation, value)
        );

        // When
        final var result = mapper.toResponseBodyList(List.of(unit));

        // Then
        assertEquals(expectedResult, result);
    }
}
