package pl.edu.agh.apdvbackend.use_cases.unit;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.Unit;
import pl.edu.agh.apdvbackend.repositories.UnitRepository;

@Component
@RequiredArgsConstructor
public class SaveUnitByNameIfNotExistImpl
        implements SaveUnitByNameIfNotExist {

    private final UnitRepository unitRepository;

    @Override
    public Unit execute(String unitName) {
        return unitRepository
                .findByName(unitName)
                .orElseGet(() -> makeAndSaveNewUnit(unitName));
    }

    private Unit makeAndSaveNewUnit(String unitName) {
        final var unit = new Unit();
        unit.setName(unitName);
        return unitRepository.save(unit);
    }
}
