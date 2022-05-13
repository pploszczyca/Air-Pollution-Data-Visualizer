package pl.edu.agh.apdvbackend.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import pl.edu.agh.apdvbackend.models.User;
import pl.edu.agh.apdvbackend.repositories.UserRepository;

import java.util.List;

@RestController
public class UserController {
    private final UserRepository userRepository;

    @Autowired
    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/user")
    public List<User> getUsers() {
        return userRepository.findAll();
    }

    @PostMapping("/user")
    public void addUser(@RequestBody User user) {
        userRepository.save(user);
    }

    @DeleteMapping("/user/{id}")
    public void removeUser(@PathVariable long id) {
        userRepository.deleteById(id);
    }
}
