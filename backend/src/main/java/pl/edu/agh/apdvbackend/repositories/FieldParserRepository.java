package pl.edu.agh.apdvbackend.repositories;

import java.util.Optional;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

@Repository
public interface FieldParserRepository extends CrudRepository<FieldParser, Long> {
    Optional<FieldParser> findByPath(String path);
}
