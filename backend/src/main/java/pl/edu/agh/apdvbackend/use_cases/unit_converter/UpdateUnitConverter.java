package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.UnitConverterResponseBody;

public interface UpdateUnitConverter {
    UnitConverterResponseBody execute(Long unitConverterId, AddUnitConverterRequestBody addUnitConverterRequestBody);
}
