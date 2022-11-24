package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.GroupRepository;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@Component
@RequiredArgsConstructor
public class DeleteUserImpl implements DeleteUser {

    private final GroupRepository groupRepository;
    private final UserRepository userRepository;

    @Override
    public void execute(Long userId) {
        removeUserFromGroups(userId);
        userRepository.deleteById(userId);
    }

    private void removeUserFromGroups(Long userId) {
        final var user = userRepository.findById(userId).orElseThrow();
        user.getGroups().forEach(group -> {
            group.removeUser(user);
            groupRepository.save(group);
        });
    }
}
