package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.Group;

@Repository
public interface GroupRepository extends CrudRepository<Group, Long> {
}
