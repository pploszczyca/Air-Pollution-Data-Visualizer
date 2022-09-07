package pl.edu.agh.apdvbackend.mappers.group_endpoint;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.fakes.GroupEndpointFakes;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class FieldsFromGroupEndpointsMapperTest {

    @Autowired
    private FieldsFromGroupEndpointsMapper mapper;

    @Test
    public void ShouldMapToDistinctFieldsList() {
        // Given
        final var firstField = FieldFakes.builder()
                .id(1L)
                .build();
        final var secondField = FieldFakes.builder()
                .id(2L)
                .build();
        final var thirdField = FieldFakes.builder()
                .id(3L)
                .build();
        final var firstGroupEndpoint = GroupEndpointFakes.builder()
                .enableFields(List.of(firstField, secondField))
                .build();
        final var secondGroupEndpoint = GroupEndpointFakes.builder()
                .enableFields(List.of(firstField, thirdField))
                .build();
        final var groupEndpoints = List.of(firstGroupEndpoint, secondGroupEndpoint);
        final var expected = List.of(firstField, secondField, thirdField);

        // When
        final var result = mapper.map(groupEndpoints);

        // Then
        assertEquals(expected, result);
    }
}
