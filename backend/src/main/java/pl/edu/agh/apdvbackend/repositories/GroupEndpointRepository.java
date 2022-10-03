package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Repository
public interface GroupEndpointRepository extends CrudRepository<GroupEndpoint, Long> {
    @Transactional
    void deleteAllByGroupId(Long groupId);
}
