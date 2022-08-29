package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.UnitConverterMapper;
import pl.edu.agh.apdvbackend.mappers.unit.UnitConverterResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.repositories.UnitConverterRepository;

@Component
@RequiredArgsConstructor
public class SaveUnitConverterImpl implements SaveUnitConverter {

    private final UnitConverterRepository unitConverterRepository;
    private final UnitConverterMapper unitConverterMapper;
    private final UnitConverterResponseBodyMapper responseBodyMapper;

    @Override
    public UnitConverterResponseBody execute(
            AddUnitConverterRequestBody addUnitConverterRequestBody) {
        final var unitConverter = unitConverterMapper
                .addRequestBodyToUnitConverter(addUnitConverterRequestBody);
        final var savedUnitConverter = unitConverterRepository.save(unitConverter);

        return responseBodyMapper.toResponseBody(savedUnitConverter);
    }
}
