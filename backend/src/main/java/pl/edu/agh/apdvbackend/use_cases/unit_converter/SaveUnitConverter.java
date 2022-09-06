package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;

public interface SaveUnitConverter {
    UnitConverterResponseBody execute(UnitConverterRequestBody unitConverterRequestBody);
}
