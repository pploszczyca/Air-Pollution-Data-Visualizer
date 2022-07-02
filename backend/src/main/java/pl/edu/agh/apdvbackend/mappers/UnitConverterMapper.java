package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.models.database.Unit;
import pl.edu.agh.apdvbackend.models.database.UnitConverter;
import pl.edu.agh.apdvbackend.repositories.UnitRepository;

@Mapper(componentModel = "spring")
public abstract class UnitConverterMapper {

    private static final String FROM_UNIT = "fromUnit";

    private static final String TO_UNIT = "toUnit";

    private static final String FROM_UNIT_EXPRESSION =
            "java(getUnit(addUnitConverterRequestBody.fromUnitId()))";

    private static final String TO_UNIT_EXPRESSION =
            "java(getUnit(addUnitConverterRequestBody.toUnitId()))";

    @Autowired
    private UnitRepository unitRepository;

    @Mapping(target = "fromUnitId", source = "unitConverter.fromUnit.id")
    @Mapping(target = "toUnitId", source = "unitConverter.toUnit.id")
    public abstract UnitConverterResponseBody unitConverterToResponseBody(
            UnitConverter unitConverter);

    public abstract List<UnitConverterResponseBody> unitConverterListToResponseBodyList(
            List<UnitConverter> unitConverterList);

    @Mapping(target = FROM_UNIT, expression = FROM_UNIT_EXPRESSION)
    @Mapping(target = TO_UNIT, expression = TO_UNIT_EXPRESSION)
    public abstract UnitConverter addRequestBodyToUnitConverter(
            AddUnitConverterRequestBody addUnitConverterRequestBody);

    @Mapping(target = FROM_UNIT, expression = FROM_UNIT_EXPRESSION)
    @Mapping(target = TO_UNIT, expression = TO_UNIT_EXPRESSION)
    public abstract UnitConverter updateAddRequestBodyToUnitConverter(
            AddUnitConverterRequestBody addUnitConverterRequestBody,
            @MappingTarget UnitConverter unitConverter);

    protected Unit getUnit(Long unitId) {
        return unitRepository.findById(unitId).orElseThrow();
    }
}
