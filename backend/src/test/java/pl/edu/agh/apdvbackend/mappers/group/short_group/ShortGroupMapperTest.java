package pl.edu.agh.apdvbackend.mappers.group.short_group;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.GroupFakes;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ShortGroupMapperTest {

    @Autowired
    private ShortGroupMapper mapper;

    @Test
    public void ShouldMapToShortGroup() {
        // Given
        final var id = 42L;
        final var name = "group name";
        final var group = GroupFakes.builder()
                .id(id)
                .name(name)
                .build();
        final var expectedResult = new ShortGroupResponseBody(id, name);

        // When
        final var result = mapper.toShortGroup(group);

        // Then
        assertEquals(expectedResult, result);
    }

    @Test
    public void ShouldMapToShortGroupList() {
        // Given
        final var id = 42L;
        final var name = "group name";
        final var group = GroupFakes.builder()
                .id(id)
                .name(name)
                .build();
        final var groups = List.of(group);
        final var expectedResult = List.of(new ShortGroupResponseBody(id, name));

        // When
        final var result = mapper.toShortGroupList(groups);

        // Then
        assertEquals(expectedResult, result);
    }
}