package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.Field;

@Repository
public interface FieldRepository extends CrudRepository<Field, Long> {

    @Query("SELECT DISTINCT e.enableFields FROM User u " +
            "INNER JOIN u.groups g " +
            "INNER JOIN g.groupEndpoints e " +
            "WHERE u.id = ?1 AND e.endpoint.id = ?2")
    Iterable<Field> findAllThatAreEnable(Long userId, Long endpointId);
}
