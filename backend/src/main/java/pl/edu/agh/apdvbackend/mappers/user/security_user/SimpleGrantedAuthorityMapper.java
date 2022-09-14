package pl.edu.agh.apdvbackend.mappers.user.security_user;

import java.util.Collection;
import org.mapstruct.Mapper;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring")
public abstract class SimpleGrantedAuthorityMapper {
    public Collection<SimpleGrantedAuthority> map(User user) {
        return user
                .getRoles()
                .stream()
                .map(role -> new SimpleGrantedAuthority(role.name()))
                .toList();
    }
}
