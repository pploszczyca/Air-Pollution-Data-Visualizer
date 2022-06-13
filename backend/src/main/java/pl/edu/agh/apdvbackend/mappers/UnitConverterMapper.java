package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.models.Unit;
import pl.edu.agh.apdvbackend.models.UnitConverter;
import pl.edu.agh.apdvbackend.repositories.UnitRepository;

@Mapper(componentModel = "spring")
public abstract class UnitConverterMapper {

    @Autowired
    private UnitRepository unitRepository;

    @Mapping(target = "fromUnitId", source = "unitConverter.fromUnit.id")
    @Mapping(target = "toUnitId", source = "unitConverter.toUnit.id")
    public abstract UnitConverterResponseBody unitConverterToResponseBody(UnitConverter unitConverter);

    public abstract List<UnitConverterResponseBody> unitConverterListToResponseBodyList(List<UnitConverter> unitConverterList);

    @Mapping(target = "fromUnit", expression = "java(getUnit(addUnitConverterRequestBody.fromUnitId()))")
    @Mapping(target = "toUnit", expression = "java(getUnit(addUnitConverterRequestBody.toUnitId()))")
    public abstract UnitConverter addRequestBodyToUnitConverter(
            AddUnitConverterRequestBody addUnitConverterRequestBody);

    protected Unit getUnit(Long unitId) {
        return unitRepository.findById(unitId).orElseThrow();
    }
}
