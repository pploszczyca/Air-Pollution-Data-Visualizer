package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.unit_converter.AddUnitConverterRequestBodyMapper;
import pl.edu.agh.apdvbackend.mappers.unit_converter.UnitConverterResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.repositories.UnitConverterRepository;

@Component
@RequiredArgsConstructor
public class SaveUnitConverterImpl implements SaveUnitConverter {

    private final UnitConverterRepository unitConverterRepository;
    private final AddUnitConverterRequestBodyMapper requestBodyMapper;
    private final UnitConverterResponseBodyMapper responseBodyMapper;

    @Override
    public UnitConverterResponseBody execute(
            AddUnitConverterRequestBody addUnitConverterRequestBody) {
        final var unitConverter = requestBodyMapper.toUnitConverter(addUnitConverterRequestBody);
        final var savedUnitConverter = unitConverterRepository.save(unitConverter);

        return responseBodyMapper.toResponseBody(savedUnitConverter);
    }
}
