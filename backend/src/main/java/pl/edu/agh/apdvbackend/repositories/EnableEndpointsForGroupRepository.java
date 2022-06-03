package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.EnableEndpointsForGroup;

@Repository
public interface EnableEndpointsForGroupRepository
        extends CrudRepository<EnableEndpointsForGroup, Long> {
    Iterable<EnableEndpointsForGroup> findAllByGroupId(Long groupId);
}
