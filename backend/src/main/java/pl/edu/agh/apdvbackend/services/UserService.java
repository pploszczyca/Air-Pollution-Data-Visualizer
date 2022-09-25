package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.user.UserRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.user.UserResponseBody;
import pl.edu.agh.apdvbackend.models.database.User;
import pl.edu.agh.apdvbackend.use_cases.user.AddUser;
import pl.edu.agh.apdvbackend.use_cases.user.DeleteUser;
import pl.edu.agh.apdvbackend.use_cases.user.GetAboutUser;
import pl.edu.agh.apdvbackend.use_cases.user.GetAllAboutUsers;
import pl.edu.agh.apdvbackend.use_cases.user.UpdateUser;

@Service
@RequiredArgsConstructor
public class UserService {

    private final GetAllAboutUsers getAllAboutUsers;
    private final GetAboutUser getAboutUser;
    private final AddUser addUser;
    private final UpdateUser updateUser;
    private final DeleteUser deleteUser;

    public Response<List<UserResponseBody>> getAllUsers() {
        return Response.withOkStatus(getAllAboutUsers.execute());
    }

    public Response<UserResponseBody> getUser(Long userId) {
        return Response.withOkStatus(getAboutUser.execute(userId));
    }

    public Response<User> addUser(UserRequestBody userRequestBody) {
        return Response.withOkStatus(addUser.execute(userRequestBody));
    }

    public Response<User> updateUser(
            Long userId,
            UserRequestBody userRequestBody
    ) {
        return Response.withOkStatus(updateUser.execute(userId, userRequestBody));
    }

    public void deleteUser(Long userId) {
        deleteUser.execute(userId);
    }
}
