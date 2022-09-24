package pl.edu.agh.apdvbackend.repositories;

import java.util.Optional;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.Unit;

@Repository
public interface UnitRepository extends CrudRepository<Unit, Long> {
    Optional<Unit> findByName(String name);
}
