package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AboutUserResponseBody;
import pl.edu.agh.apdvbackend.controllers.user.body_models.AddUserRequestBody;
import pl.edu.agh.apdvbackend.models.User;
import pl.edu.agh.apdvbackend.models.body_models.Response;
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

    public Response<List<AboutUserResponseBody>> getAllUsers() {
        return Response.withOkStatus(getAllAboutUsers.execute());
    }

    public Response<AboutUserResponseBody> getUser(Long userId) {
        return Response.withOkStatus(getAboutUser.execute(userId));
    }

    public Response<User> addUser(AddUserRequestBody addUserRequestBody) {
        return Response.withOkStatus(addUser.execute(addUserRequestBody));
    }

    public Response<User> updateUser(Long userId,
                                     AddUserRequestBody addUserRequestBody) {
        return Response.withOkStatus(
                updateUser.execute(userId, addUserRequestBody));
    }

    public void deleteUser(Long userId) {
        deleteUser.execute(userId);
    }
}
