package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import pl.edu.agh.apdvbackend.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
}
