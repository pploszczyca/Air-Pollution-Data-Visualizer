package pl.edu.agh.apdvbackend.mappers.group.admin_panel;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import pl.edu.agh.apdvbackend.fakes.EndpointFakes;
import pl.edu.agh.apdvbackend.fakes.FieldFakes;
import pl.edu.agh.apdvbackend.fakes.FieldParserFakes;
import pl.edu.agh.apdvbackend.fakes.GroupEndpointFakes;
import pl.edu.agh.apdvbackend.models.body_models.group.AdminPanelGroupResponseBody;
import pl.edu.agh.apdvbackend.models.database.Field;

@SpringBootTest
class AdminPanelGroupEndpointMapperTest {

    @SpyBean
    private AdminPanelGroupFieldMapper fieldMapper;

    @Autowired
    private AdminPanelGroupEndpointMapper mapper;

    @Test
    public void shouldMapEndpoint() {
        // Given
        final var id = 123L;
        final var label = "label";
        final var endpointNumber = 11;
        final var isBelongingToGroup = false;
        final var field = FieldFakes.getField();
        final var fieldParser = FieldParserFakes.getFieldParser();
        final List<AdminPanelGroupResponseBody.Endpoint.Field> fields = Collections.emptyList();

        final var endpoint = EndpointFakes.getEndpoint();
        endpoint.setId(id);
        endpoint.setLabel(label);
        endpoint.setEndpointNumber(endpointNumber);
        endpoint.setFieldParserMap(Map.of(field, fieldParser));

        Mockito.doReturn(fields).when(fieldMapper).toFieldList(List.of(field), Collections.emptyList());

        final var expected = new AdminPanelGroupResponseBody.Endpoint(
                id,
                label,
                endpointNumber,
                fields,
                isBelongingToGroup
        );

        // When
        final var result = mapper.toEndpoint(endpoint, null);

        // Then
        assertEquals(expected, result);
    }

    @Nested
    class GetFieldsTest {
        @Test
        public void shouldInvokeFieldMapperToFieldList() {
            // Given
            final var field = FieldFakes.getField();
            final var fieldParser = FieldParserFakes.getFieldParser();
            final var endpoint = EndpointFakes.getEndpoint();
            endpoint.setFieldParserMap(Map.of(field, fieldParser));

            final List<Field> enableFields = List.of(field);
            final var groupEndpoint = GroupEndpointFakes.getGroupEndpoint();
            groupEndpoint.setEnableFields(enableFields);

            // When
            mapper.getFields(endpoint, groupEndpoint);

            // Then
            Mockito.verify(fieldMapper)
                    .toFieldList(List.of(field), enableFields);
        }

        @Test
        public void shouldInvokeWithEmptyList_WhenGroupEndpointIsNull() {
            // Given
            final var endpoint = EndpointFakes.getEndpoint();
            final List<Field> enableFields = Collections.emptyList();

            // When
            mapper.getFields(endpoint, null);

            // Then
            Mockito.verify(fieldMapper)
                    .toFieldList(Mockito.any(), Mockito.eq(enableFields));
        }
    }

    @Nested
    class IsBelongingToGroupTest {
        @Test
        public void returnTrue_WhenGroupEndpointIsNotNull() {
            // Given
            final var groupEndpoint = GroupEndpointFakes.getGroupEndpoint();

            // When
            final var result = mapper.isBelongingToGroup(groupEndpoint);

            // Then
            assertTrue(result);
        }

        @Test
        public void returnFalse_WhenGroupEndpointIsNull() {
            // Given

            // When
            final var result = mapper.isBelongingToGroup(null);

            // Then
            assertFalse(result);
        }
    }
}
