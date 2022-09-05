package pl.edu.agh.apdvbackend.use_cases.user;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public interface FindSecurityUserByEmail {
    User execute(String email) throws UsernameNotFoundException;
}
