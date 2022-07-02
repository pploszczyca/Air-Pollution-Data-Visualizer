package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.User;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@Component
@RequiredArgsConstructor
public class GetUserImpl
        implements GetUser {

    private final UserRepository userRepository;

    @Override
    public User execute(Long userId) {
        return userRepository.findById(userId).orElseThrow();
    }
}
