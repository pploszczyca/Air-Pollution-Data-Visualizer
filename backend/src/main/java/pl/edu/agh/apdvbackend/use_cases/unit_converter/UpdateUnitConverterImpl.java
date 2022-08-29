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
public class UpdateUnitConverterImpl implements UpdateUnitConverter {

    private final UnitConverterRepository unitConverterRepository;
    private final AddUnitConverterRequestBodyMapper requestBodyMapper;
    private final UnitConverterResponseBodyMapper responseBodyMapper;

    @Override
    public UnitConverterResponseBody execute(
            Long unitConverterId,
            AddUnitConverterRequestBody requestBody
    ) {
        final var unitConverter = unitConverterRepository
                .findById(unitConverterId)
                .orElseThrow();
        final var updatedUnitConverter = requestBodyMapper.updateUnitConverter(requestBody, unitConverter);

        return responseBodyMapper.toResponseBody(unitConverterRepository.save(updatedUnitConverter));
    }
}
