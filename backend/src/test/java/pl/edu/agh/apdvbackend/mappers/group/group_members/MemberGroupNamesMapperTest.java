package pl.edu.agh.apdvbackend.mappers.group.group_members;

import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import pl.edu.agh.apdvbackend.fakes.GroupFakes;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class MemberGroupNamesMapperTest {

    @Autowired
    private MemberGroupNamesMapper mapper;

    @Test
    public void ShouldMapToOtherGroupNames() {
        // Given
        final var firstGroupId = 22L;
        final var secondGroupId = 23L;
        final var thirdGroupId = 24L;
        final var firstGroupName = "firstGroupName";
        final var secondGroupName = "secondGroupName";
        final var thirdGroupName = "thirdGroupName";
        final var firstGroup = GroupFakes.builder()
                .id(firstGroupId)
                .name(firstGroupName)
                .build();
        final var secondGroup = GroupFakes.builder()
                .id(secondGroupId)
                .name(secondGroupName)
                .build();
        final var thirdGroup = GroupFakes.builder()
                .id(thirdGroupId)
                .name(thirdGroupName)
                .build();
        final var groups = Set.of(firstGroup, secondGroup, thirdGroup);
        final var expectedNames = List.of(secondGroupName, thirdGroupName);

        // When
        final var result = mapper.toOtherGroupNames(groups, firstGroupId);

        // Then
        assertEquals(expectedNames, result);
    }
}
