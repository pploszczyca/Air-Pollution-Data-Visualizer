package pl.edu.agh.apdvbackend.mappers.group.group_members;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import pl.edu.agh.apdvbackend.fakes.UserFakes;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupMembersResponseBody;
import pl.edu.agh.apdvbackend.models.database.Group;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class MemberMapperTest {

    @SpyBean
    private MemberGroupNamesMapper groupNamesMapper;

    @Autowired
    private MemberMapper mapper;

    @Test
    public void ShouldMapToMember() {
        // Given
        final var groupId = 33L;
        final var userId = 22L;
        final var userEmail = "user@email.com";
        final Set<Group> userGroups = Collections.emptySet();
        final var user = UserFakes.builder()
                .id(userId)
                .email(userEmail)
                .groups(userGroups)
                .build();
        final List<String> groupNames = Collections.emptyList();
        final var expectedMember = new GroupMembersResponseBody.Member(userId, userEmail, groupNames);

        Mockito.doReturn(groupNames)
                .when(groupNamesMapper).toOtherGroupNames(userGroups, groupId);

        // When
        final var result = mapper.toMember(user, groupId);

        // Then
        assertEquals(expectedMember, result);
    }

    @Test
    public void ShouldMapToMemberList() {
        // Given
        final var groupId = 33L;
        final var userId = 22L;
        final var userEmail = "user@email.com";
        final Set<Group> userGroups = Collections.emptySet();
        final var user = UserFakes.builder()
                .id(userId)
                .email(userEmail)
                .groups(userGroups)
                .build();
        final var users = Set.of(user);
        final List<String> groupNames = Collections.emptyList();
        final var expectedMembers = List.of(new GroupMembersResponseBody.Member(userId, userEmail, groupNames));

        Mockito.doReturn(groupNames)
                .when(groupNamesMapper).toOtherGroupNames(userGroups, groupId);

        // When
        final var result = mapper.toMemberList(users, groupId);

        // Then
        assertEquals(expectedMembers, result);
    }

}
