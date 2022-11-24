package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.user.ShortUserResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;
import pl.edu.agh.apdvbackend.models.database.Group;
import pl.edu.agh.apdvbackend.repositories.UserRepository;
import pl.edu.agh.apdvbackend.utilities.StreamUtilities;

@Component
@RequiredArgsConstructor
public class GetNotMembersOfTheGroupImpl implements GetNotMembersOfTheGroup {

    private final UserRepository userRepository;
    private final StreamUtilities streamUtilities;
    private final ShortUserResponseBodyMapper shortUserMapper;

    @Override
    public List<ShortUserResponseBody> execute(Long groupId) {
        return streamUtilities
                .asStream(userRepository.findAll())
                .filter(user -> user.
                        getGroups()
                        .stream()
                        .map(Group::getId)
                        .noneMatch(id -> id.equals(groupId)))
                .map(shortUserMapper::toShortUser)
                .toList();
    }
}
