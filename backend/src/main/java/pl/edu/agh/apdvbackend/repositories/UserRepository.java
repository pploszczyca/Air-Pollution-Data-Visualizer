package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
}
