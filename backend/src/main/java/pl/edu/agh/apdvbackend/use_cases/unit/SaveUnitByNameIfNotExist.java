package pl.edu.agh.apdvbackend.use_cases.unit;

import pl.edu.agh.apdvbackend.models.database.Unit;

public interface SaveUnitByNameIfNotExist {
    Unit execute(String unitName);
}
