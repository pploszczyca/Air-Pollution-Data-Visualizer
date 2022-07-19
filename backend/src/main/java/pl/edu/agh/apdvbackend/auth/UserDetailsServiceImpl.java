package pl.edu.agh.apdvbackend.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.use_cases.user.FindSecurityUserByEmail;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final FindSecurityUserByEmail findSecurityUserByEmail;

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
        return findSecurityUserByEmail.execute(username);
    }
}
