package pl.edu.agh.apdvbackend.use_cases.user;

import org.springframework.security.core.userdetails.UsernameNotFoundException;

public interface FindUserByEmail {
    org.springframework.security.core.userdetails.User execute(String email) throws
            UsernameNotFoundException;
}
