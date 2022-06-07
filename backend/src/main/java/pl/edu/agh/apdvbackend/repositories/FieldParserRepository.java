package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.FieldParser;

@Repository
public interface FieldParserRepository
        extends CrudRepository<FieldParser, Long> {
}
