package pl.edu.agh.apdvbackend.repositories;

import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Repository
public interface GroupRepositoryRepository
        extends CrudRepository<GroupEndpoint, Long> {
    Optional<GroupEndpoint> findByGroupIdAndEndpointId(Long groupId,
                                                       Long endpointId);

    @Query("SELECT ee FROM GroupEndpoint ee " +
            "INNER JOIN ee.group g " +
            "INNER JOIN g.usersInGroup u " +
            "WHERE u.id = ?1 AND ee.endpoint.id = ?2")
    Optional<GroupEndpoint> findByUserIdAndEndpointId(Long userId,
                                                      Long endpointId);

    @Query("SELECT ee FROM GroupEndpoint ee " +
            "INNER JOIN ee.group g " +
            "INNER JOIN g.usersInGroup u " +
            "WHERE u.id = ?1 AND ee.endpoint.id = ?2")
    Iterable<GroupEndpoint> findAllUserIdAndEndpointId(Long userId,
                                                       Long endpointId);
}
