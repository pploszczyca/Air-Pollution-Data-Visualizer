package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@Component
@RequiredArgsConstructor
public class DeleteUserImpl implements DeleteUser {

    private final UserRepository userRepository;

    @Override
    public void execute(Long userId) {
        userRepository.deleteById(userId);
    }
}
