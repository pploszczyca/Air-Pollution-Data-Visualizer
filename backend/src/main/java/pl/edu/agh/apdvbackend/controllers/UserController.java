package pl.edu.agh.apdvbackend.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.user.AboutUserResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.user.AddUserRequestBody;
import pl.edu.agh.apdvbackend.models.database.User;
import pl.edu.agh.apdvbackend.services.UserService;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
@Tag(name = "User")
public class UserController {

    private final UserService userService;

    @Operation(summary = "Get all users information")
    @GetMapping("/all")
    public Response<List<AboutUserResponseBody>> getAllUsers() {
        return userService.getAllUsers();
    }

    @Operation(summary = "Get user information")
    @GetMapping
    public Response<AboutUserResponseBody> getUser(@RequestParam Long userId) {
        return userService.getUser(userId);
    }

    @Operation(summary = "Add new user")
    @PostMapping
    public Response<User> addUser(
            @RequestBody AddUserRequestBody addUserRequestBody) {
        return userService.addUser(addUserRequestBody);
    }

    @Operation(summary = "Update user")
    @PutMapping
    public Response<User> updateUser(@RequestParam Long userId, @RequestBody
    AddUserRequestBody addUserRequestBody) {
        return userService.updateUser(userId, addUserRequestBody);
    }

    @Operation(summary = "Delete user")
    @DeleteMapping
    public void deleteUser(@RequestParam Long userId) {
        userService.deleteUser(userId);
    }
}
