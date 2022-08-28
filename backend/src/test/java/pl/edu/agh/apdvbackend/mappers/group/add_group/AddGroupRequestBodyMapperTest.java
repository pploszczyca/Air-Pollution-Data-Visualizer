package pl.edu.agh.apdvbackend.mappers.group.add_group;

import java.util.ArrayList;
import java.util.HashSet;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.GroupFakes;
import pl.edu.agh.apdvbackend.models.body_models.group.AddGroupRequestBody;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class AddGroupRequestBodyMapperTest {

    @Autowired
    private AddGroupRequestBodyMapper mapper;

    @Test
    public void ShouldMapToGroup() {
        // Given
        final var groupName = "groupName";
        final var requestBody = new AddGroupRequestBody(groupName);
        final var expectedResult = GroupFakes.builder()
                .id(null)
                .name(groupName)
                .usersInGroup(new HashSet<>())
                .groupEndpoints(new ArrayList<>())
                .build();

        // When
        final var result = mapper.toGroup(requestBody);

        // Then
        assertEquals(expectedResult, result);
    }
}
