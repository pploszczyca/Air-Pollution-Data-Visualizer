package pl.edu.agh.apdvbackend.mappers.group;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.SpyBean;
import pl.edu.agh.apdvbackend.fakes.GroupFakes;
import pl.edu.agh.apdvbackend.models.body_models.group.GroupMembersResponseBody;
import pl.edu.agh.apdvbackend.models.database.User;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class GroupMembersMapperTest {

    @SpyBean
    private MemberMapper memberMapper;

    @Autowired
    private GroupMembersMapper mapper;

    @Test
    public void shouldMapToResponseBody() {
        // Given
        final var groupId = 2137L;
        final var groupName = "groupName";
        final var group = GroupFakes.getGroup();
        final Set<User> usersInGroup = Collections.emptySet();
        final List<GroupMembersResponseBody.Member> members = Collections.emptyList();
        group.setId(groupId);
        group.setName(groupName);
        group.setUsersInGroup(usersInGroup);
        final var expected = new GroupMembersResponseBody(groupId, groupName, members);

        Mockito.doReturn(members)
                .when(memberMapper).toMemberList(usersInGroup, groupId);

        // When
        final var result = mapper.map(group);

        // Then
        assertEquals(expected, result);
    }
}
