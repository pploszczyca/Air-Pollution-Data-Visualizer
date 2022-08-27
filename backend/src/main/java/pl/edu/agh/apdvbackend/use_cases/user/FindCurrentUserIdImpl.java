package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@Component
@RequiredArgsConstructor
public class FindCurrentUserIdImpl implements FindCurrentUserId {

    private final UserRepository userRepository;

    @Override
    public Long execute() {
        final var email = SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getName();

        return userRepository
                .findByEmail(email)
                .orElseThrow()
                .getId();
    }
}
