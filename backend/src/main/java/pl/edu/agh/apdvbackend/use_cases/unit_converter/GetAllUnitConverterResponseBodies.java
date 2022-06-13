package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import java.util.List;
import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.UnitConverterResponseBody;

public interface GetAllUnitConverterResponseBodies {
    List<UnitConverterResponseBody> execute();
}
