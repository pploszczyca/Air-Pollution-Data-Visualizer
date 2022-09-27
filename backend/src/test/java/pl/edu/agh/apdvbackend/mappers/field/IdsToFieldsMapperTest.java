package pl.edu.agh.apdvbackend.mappers.field;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.doReturn;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class IdsToFieldsMapperTest {

    @MockBean
    private GetField getField;

    @Autowired
    private IdsToFieldsMapper mapper;

    @Test
    public void ShouldMapToFields() {
        // Given
        final var firstFieldId = 24L;
        final var secondFieldId = 25L;
        final var fieldIds = List.of(firstFieldId, secondFieldId);
        final var firstField = FieldFakes.builder()
                .id(firstFieldId)
                .build();
        final var secondField = FieldFakes.builder()
                .id(secondFieldId)
                .build();
        final var expected = List.of(firstField, secondField);

        doReturn(firstField).when(getField).execute(firstFieldId);
        doReturn(secondField).when(getField).execute(secondFieldId);

        // When
        final var result = mapper.toFields(fieldIds);

        // Then
        assertThat(result).usingRecursiveComparison().isEqualTo(expected);
    }
}
