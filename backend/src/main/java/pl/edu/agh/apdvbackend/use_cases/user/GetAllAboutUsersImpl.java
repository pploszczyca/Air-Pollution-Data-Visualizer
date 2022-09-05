package pl.edu.agh.apdvbackend.use_cases.user;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.UserMapper;
import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;
import pl.edu.agh.apdvbackend.repositories.UserRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllAboutUsersImpl implements GetAllAboutUsers {

    private final UserMapper userMapper;
    private final UserRepository userRepository;
    private final ListUtilities listUtilities;

    @Override
    public List<UserResponseBody> execute() {
        final var userList = listUtilities.iterableToList(userRepository.findAll());
        return userMapper.userListToAboutResponseBodyList(userList);
    }
}
