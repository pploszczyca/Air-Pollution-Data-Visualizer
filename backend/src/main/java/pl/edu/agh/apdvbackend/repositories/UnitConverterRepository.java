package pl.edu.agh.apdvbackend.repositories;

import org.springframework.data.repository.CrudRepository;
import pl.edu.agh.apdvbackend.models.UnitConverter;

public interface UnitConverterRepository extends CrudRepository<UnitConverter, Long> {
    Iterable<UnitConverter> findAllByFromUnitIdOrToUnitId(Long fromUnitId, Long toUnitId);
}
