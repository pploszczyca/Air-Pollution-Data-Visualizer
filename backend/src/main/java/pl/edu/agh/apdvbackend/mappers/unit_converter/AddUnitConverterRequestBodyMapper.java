package pl.edu.agh.apdvbackend.mappers.unit_converter;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.database.Unit;
import pl.edu.agh.apdvbackend.models.database.UnitConverter;
import pl.edu.agh.apdvbackend.repositories.UnitRepository;

@Mapper(componentModel = "spring")
public abstract class AddUnitConverterRequestBodyMapper {

    @Autowired
    private UnitRepository unitRepository;

    @UnitConverterMapping
    public abstract UnitConverter toUnitConverter(AddUnitConverterRequestBody requestBody);

    @UnitConverterMapping
    public abstract UnitConverter updateUnitConverter(
            AddUnitConverterRequestBody requestBody,
            @MappingTarget UnitConverter unitConverter
    );

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "fromUnit", expression = "java(getUnit(requestBody.fromUnitId()))")
    @Mapping(target = "toUnit", expression = "java(getUnit(requestBody.toUnitId()))")
    private @interface UnitConverterMapping {
    }

    protected Unit getUnit(Long unitId) {
        return unitRepository.findById(unitId).orElseThrow();
    }
}
