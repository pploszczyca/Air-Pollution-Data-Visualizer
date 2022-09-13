package pl.edu.agh.apdvbackend.mappers.unit;

import java.util.Optional;
import org.mapstruct.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.database.Unit;
import pl.edu.agh.apdvbackend.repositories.UnitRepository;

@Mapper(componentModel = "spring")
public abstract class UnitNameMapper {
    @Autowired
    private UnitRepository unitRepository;

    public Unit toUnit(Optional<String> unitName) {
        return unitName
                .map(presentUnitName -> unitRepository
                        .findByName(presentUnitName)
                        .orElseThrow()
                )
                .orElse(null);
    }
}
