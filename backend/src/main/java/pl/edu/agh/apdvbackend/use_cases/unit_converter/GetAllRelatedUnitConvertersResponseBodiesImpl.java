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
public class GetAllRelatedUnitConvertersResponseBodiesImpl implements GetAllRelatedUnitConvertersResponseBodies {

    private final UnitConverterRepository converterRepository;
    private final UnitConverterResponseBodyMapper responseBodyMapper;
    private final ListUtilities listUtilities;


    @Override
    public List<UnitConverterResponseBody> execute(Long unitId) {
        final var unitConverterIterable = converterRepository
                .findAllByFromUnitIdOrToUnitId(unitId, unitId);
        final var unitConverterList = listUtilities
                .iterableToList(unitConverterIterable);
        return responseBodyMapper.toResponseBodyList(unitConverterList);
    }
}
