package pl.edu.agh.apdvbackend.repositories;

import java.util.Optional;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.EnableEndpointsForGroup;

@Repository
public interface EnableEndpointsForGroupRepository
        extends CrudRepository<EnableEndpointsForGroup, Long> {
    Optional<EnableEndpointsForGroup> findByGroupIdAndEndpointId(Long groupId,
                                                                 Long endpointId);
}
