package pl.edu.agh.apdvbackend.use_cases.user;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.user.security_user.SecurityUserMapper;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

@Component
@RequiredArgsConstructor
public class FindSecurityUserByEmailImpl implements FindSecurityUserByEmail {

    public static final String USER_NOT_FOUND = "User not found in the database";
    private final UserRepository userRepository;
    private final SecurityUserMapper securityUserMapper;

    @Override
    public User execute(String email) throws UsernameNotFoundException {
        final var databaseUser = userRepository
                .findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException(USER_NOT_FOUND));

        return securityUserMapper.map(databaseUser);
    }
}
