package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.edu.agh.apdvbackend.models.database.GroupEndpoint;

@Repository
public interface GroupEndpointRepository extends CrudRepository<GroupEndpoint, Long> {
    @Query(value = "DELETE FROM enable_fields WHERE enable_fields.gropu_id = :myGroupId ;" +
            "DELETE FROM group_endpoint WHERE group_endpoint.group_id = :myGroupId ; "
            , nativeQuery = true)
    @Modifying
    @Transactional
    void deleteAllMyFunction(@Param("myGroupId") Long groupId);
}
