package pl.edu.agh.apdvbackend.use_cases.group;

import java.util.List;

public interface GetNotMembersOfTheGroup {

    List<ShortUser> execute(Long groupId);

    record ShortUser(
            Long id,
            String email
    ) {
    }
}
