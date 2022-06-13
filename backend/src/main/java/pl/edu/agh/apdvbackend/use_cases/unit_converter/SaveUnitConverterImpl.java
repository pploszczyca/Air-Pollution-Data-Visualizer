package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.mappers.UnitConverterMapper;
import pl.edu.agh.apdvbackend.repositories.UnitConverterRepository;

@Component
@RequiredArgsConstructor
public class SaveUnitConverterImpl
        implements SaveUnitConverter {

    private final UnitConverterRepository unitConverterRepository;

    private final UnitConverterMapper unitConverterMapper;

    @Override
    public UnitConverterResponseBody execute(
            AddUnitConverterRequestBody addUnitConverterRequestBody) {
        final var unitConverter = unitConverterMapper.addRequestBodyToUnitConverter(addUnitConverterRequestBody);
        final var savedUnitConverter = unitConverterRepository.save(unitConverter);

        return unitConverterMapper.unitConverterToResponseBody(savedUnitConverter);
    }
}
