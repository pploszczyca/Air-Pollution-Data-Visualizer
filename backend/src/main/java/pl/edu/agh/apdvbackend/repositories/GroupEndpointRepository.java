package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Repository
public interface GroupEndpointRepository extends CrudRepository<GroupEndpoint, Long> {
}
