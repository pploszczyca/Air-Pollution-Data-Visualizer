package pl.edu.agh.apdvbackend.mappers.unit;

import java.util.Optional;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import pl.edu.agh.apdvbackend.fakes.UnitFakes;
import pl.edu.agh.apdvbackend.repositories.UnitRepository;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.Mockito.doReturn;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class UnitNameMapperTest {

    @MockBean
    private UnitRepository unitRepository;

    @Autowired
    private UnitNameMapper mapper;

    @Test
    public void ShouldReturnUnit_WhenOptionalIsNotEmpty() {
        // Given
        final String unitName = "unitName";
        final var unitNameOptional = Optional.of(unitName);
        final var unit = UnitFakes
                .builder()
                .name(unitName)
                .build();

        doReturn(Optional.of(unit))
                .when(unitRepository).findByName(unitName);

        // When
        final var result = mapper.toUnit(unitNameOptional);

        // Then
        assertEquals(unit, result);
    }

    @Test
    public void ShouldReturnNull_WhenOptionalIsEmpty() {
        // Given
        final Optional<String> unitNameOptional = Optional.empty();

        // When
        final var result = mapper.toUnit(unitNameOptional);

        // Then
        assertNull(result);
    }
}
