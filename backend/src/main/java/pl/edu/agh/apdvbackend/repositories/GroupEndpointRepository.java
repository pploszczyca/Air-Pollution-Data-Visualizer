package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Repository
public interface GroupEndpointRepository extends CrudRepository<GroupEndpoint, Long> {

    @Query("SELECT ee FROM GroupEndpoint ee " +
            "INNER JOIN ee.group g " +
            "INNER JOIN g.usersInGroup u " +
            "WHERE u.id = ?1 AND ee.endpoint.id = ?2")
    Iterable<GroupEndpoint> findAllUserIdAndEndpointId(Long userId,
                                                       Long endpointId);
}
