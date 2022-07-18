package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.Field;

@Repository
public interface FieldRepository extends CrudRepository<Field, Long> {
}
