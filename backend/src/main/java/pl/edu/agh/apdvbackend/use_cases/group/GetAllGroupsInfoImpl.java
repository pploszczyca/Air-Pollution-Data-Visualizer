package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.group.short_group.ShortGroupMapper;
import pl.edu.agh.apdvbackend.models.body_models.group.ShortGroupResponseBody;
import pl.edu.agh.apdvbackend.repositories.GroupRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllGroupsInfoImpl implements GetAllGroupsInfo {

    private final GroupRepository groupRepository;
    private final ShortGroupMapper shortGroupMapper;
    private final ListUtilities listUtilities;

    @Override
    public List<ShortGroupResponseBody> execute() {
        final var groupList = listUtilities
                .iterableToList(groupRepository.findAll());
        return shortGroupMapper.toShortGroupList(groupList);
    }
}
