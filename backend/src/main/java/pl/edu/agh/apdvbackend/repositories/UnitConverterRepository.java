package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import pl.edu.agh.apdvbackend.models.database.UnitConverter;

@Repository
public interface UnitConverterRepository
        extends CrudRepository<UnitConverter, Long> {
    Iterable<UnitConverter> findAllByFromUnitIdOrToUnitId(Long fromUnitId,
                                                          Long toUnitId);
}
