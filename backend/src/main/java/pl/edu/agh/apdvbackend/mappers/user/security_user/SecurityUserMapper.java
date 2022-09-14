package pl.edu.agh.apdvbackend.mappers.user.security_user;

import org.mapstruct.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.database.User;

@Mapper(componentModel = "spring")
public abstract class SecurityUserMapper {

    @Autowired
    private SimpleGrantedAuthorityMapper simpleGrantedAuthorityMapper;

    public org.springframework.security.core.userdetails.User map(User user) {
        return new org.springframework.security.core.userdetails.User(
                user.getEmail(),
                user.getPassword(),
                simpleGrantedAuthorityMapper.map(user)
        );
    }
}
