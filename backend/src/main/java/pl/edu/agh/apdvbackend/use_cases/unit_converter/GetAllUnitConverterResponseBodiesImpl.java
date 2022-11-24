package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.unit_converter.UnitConverterResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.repositories.UnitConverterRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllUnitConverterResponseBodiesImpl implements GetAllUnitConverterResponseBodies {

    private final UnitConverterRepository converterRepository;
    private final UnitConverterResponseBodyMapper responseBodyMapper;
    private final ListUtilities listUtilities;

    @Override
    public List<UnitConverterResponseBody> execute() {
        final var unitConverterList = listUtilities
                .iterableToList(converterRepository.findAll());
        return responseBodyMapper.toResponseBodyList(unitConverterList);
    }
}
