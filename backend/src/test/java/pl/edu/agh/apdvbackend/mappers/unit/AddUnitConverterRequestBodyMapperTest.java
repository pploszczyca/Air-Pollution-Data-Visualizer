package pl.edu.agh.apdvbackend.mappers.unit;

import java.util.Optional;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import pl.edu.agh.apdvbackend.fakes.UnitConverterFakes;
import pl.edu.agh.apdvbackend.fakes.UnitFakes;
import pl.edu.agh.apdvbackend.mappers.unit_converter.AddUnitConverterRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.database.MathOperation;
import pl.edu.agh.apdvbackend.repositories.UnitRepository;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class AddUnitConverterRequestBodyMapperTest {

    @SpyBean
    private UnitRepository unitRepository;

    @Autowired
    private AddUnitConverterRequestBodyMapper mapper;

    @Test
    public void ShouldMapToUnitConverter() {
        // Given
        final var fromUnitId = 23L;
        final var toUnitId = 100L;
        final var calculationStep = 52;
        final var mathOperation = MathOperation.SUBTRACTION;
        final var value = 1000.2;
        final var fromUnit = UnitFakes.builder()
                .id(fromUnitId)
                .build();
        final var toUnit = UnitFakes.builder()
                .id(toUnitId)
                .build();
        final var addUnitConverterRequestBody =
                new AddUnitConverterRequestBody(fromUnitId, toUnitId, calculationStep, mathOperation, value);
        final var expectedResult = UnitConverterFakes.builder()
                .id(null)
                .fromUnit(fromUnit)
                .toUnit(toUnit)
                .calculationStep(calculationStep)
                .mathOperation(mathOperation)
                .value(value)
                .build();

        Mockito.doReturn(Optional.of(fromUnit))
                .when(unitRepository).findById(fromUnitId);
        Mockito.doReturn(Optional.of(toUnit))
                .when(unitRepository).findById(toUnitId);

        // When
        final var result = mapper.toUnitConverter(addUnitConverterRequestBody);

        // Then
        assertEquals(expectedResult, result);
    }

    @Test
    public void ShouldUpdateUnitConverter() {
        // Given
        final var id = 43L;
        final var fromUnitId = 23L;
        final var toUnitId = 100L;
        final var calculationStep = 52;
        final var mathOperation = MathOperation.SUBTRACTION;
        final var value = 1000.2;
        final var fromUnit = UnitFakes.builder()
                .id(fromUnitId)
                .build();
        final var toUnit = UnitFakes.builder()
                .id(toUnitId)
                .build();
        final var addUnitConverterRequestBody =
                new AddUnitConverterRequestBody(fromUnitId, toUnitId, calculationStep, mathOperation, value);
        final var unitConverterToUpdate = UnitConverterFakes.builder()
                .id(id)
                .build();
        final var expectedResult = UnitConverterFakes.builder()
                .id(id)
                .fromUnit(fromUnit)
                .toUnit(toUnit)
                .calculationStep(calculationStep)
                .mathOperation(mathOperation)
                .value(value)
                .build();

        Mockito.doReturn(Optional.of(fromUnit))
                .when(unitRepository).findById(fromUnitId);
        Mockito.doReturn(Optional.of(toUnit))
                .when(unitRepository).findById(toUnitId);

        // When
        mapper.updateUnitConverter(addUnitConverterRequestBody, unitConverterToUpdate);

        // Then
        assertEquals(expectedResult, unitConverterToUpdate);
    }
}
