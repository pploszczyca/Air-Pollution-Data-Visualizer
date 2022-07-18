package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;

public interface GetAllRelatedUnitConvertersResponseBodies {
    List<UnitConverterResponseBody> execute(Long unitId);
}
