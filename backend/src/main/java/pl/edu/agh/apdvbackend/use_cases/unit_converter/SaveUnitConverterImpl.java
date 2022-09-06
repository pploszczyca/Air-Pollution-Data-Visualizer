package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.unit_converter.UnitConverterRequestBodyMapper;
import pl.edu.agh.apdvbackend.mappers.unit_converter.UnitConverterResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.repositories.UnitConverterRepository;

@Component
@RequiredArgsConstructor
public class SaveUnitConverterImpl implements SaveUnitConverter {

    private final UnitConverterRepository unitConverterRepository;
    private final UnitConverterRequestBodyMapper requestBodyMapper;
    private final UnitConverterResponseBodyMapper responseBodyMapper;

    @Override
    public UnitConverterResponseBody execute(
            UnitConverterRequestBody unitConverterRequestBody) {
        final var unitConverter = requestBodyMapper.toUnitConverter(unitConverterRequestBody);
        final var savedUnitConverter = unitConverterRepository.save(unitConverter);

        return responseBodyMapper.toResponseBody(savedUnitConverter);
    }
}
