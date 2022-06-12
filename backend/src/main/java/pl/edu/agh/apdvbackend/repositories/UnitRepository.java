package pl.edu.agh.apdvbackend.repositories;

import java.util.Optional;
import org.springframework.data.repository.CrudRepository;
import pl.edu.agh.apdvbackend.models.Unit;

public interface UnitRepository extends CrudRepository<Unit, Long> {
    boolean existsByName(String name);

    Optional<Unit> findByName(String name);
}
