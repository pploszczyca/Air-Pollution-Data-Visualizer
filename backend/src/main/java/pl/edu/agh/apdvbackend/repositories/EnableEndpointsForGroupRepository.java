package pl.edu.agh.apdvbackend.repositories;

import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.EnableEndpointsForGroup;

@Repository
public interface EnableEndpointsForGroupRepository
        extends CrudRepository<EnableEndpointsForGroup, Long> {
    Optional<EnableEndpointsForGroup> findByGroupIdAndEndpointId(Long groupId,
                                                                 Long endpointId);

    @Query("SELECT ee FROM EnableEndpointsForGroup ee " +
            "INNER JOIN ee.group g " +
            "INNER JOIN g.usersInGroup u " +
            "WHERE u.id = ?1 AND ee.endpoint.id = ?2")
    Optional<EnableEndpointsForGroup> findByUserIdAndEndpointId(Long userId,
                                                                Long endpointId);

    @Query("SELECT ee FROM EnableEndpointsForGroup ee " +
            "INNER JOIN ee.group g " +
            "INNER JOIN g.usersInGroup u " +
            "WHERE u.id = ?1 AND ee.endpoint.id = ?2")
    Iterable<EnableEndpointsForGroup> findAllUserIdAndEndpointId(Long userId,
                                                                Long endpointId);
}
