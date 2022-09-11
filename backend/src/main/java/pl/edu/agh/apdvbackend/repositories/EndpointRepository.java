package pl.edu.agh.apdvbackend.repositories;

import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

@Repository
public interface EndpointRepository extends CrudRepository<Endpoint, Long> {

    @Query("SELECT e.endpoint FROM User u " +
            "INNER JOIN u.groups g " +
            "INNER JOIN g.groupEndpoints e " +
            "WHERE u.id = ?1")
    Iterable<Endpoint> findAllThatBelongToUser(Long userId);

    @Query("SELECT e.endpoint FROM User u " +
            "INNER JOIN u.groups g " +
            "INNER JOIN g.groupEndpoints e " +
            "WHERE u.id = ?1 AND e.id = ?2")
    Optional<Endpoint> findThatBelongToUser(Long userId, Long endpointId);
}
