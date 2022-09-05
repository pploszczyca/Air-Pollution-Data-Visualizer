package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import pl.edu.agh.apdvbackend.models.body_models.unit_converter.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;

public interface UpdateUnitConverter {
    UnitConverterResponseBody execute(
            Long unitConverterId,
            AddUnitConverterRequestBody addUnitConverterRequestBody
    );
}
