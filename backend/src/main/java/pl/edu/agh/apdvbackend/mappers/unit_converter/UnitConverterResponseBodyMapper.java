package pl.edu.agh.apdvbackend.mappers.unit_converter;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.models.database.UnitConverter;

@Mapper(componentModel = "spring")
public interface UnitConverterResponseBodyMapper {

    @Mapping(target = "fromUnitId", source = "unitConverter.fromUnit.id")
    @Mapping(target = "toUnitId", source = "unitConverter.toUnit.id")
    UnitConverterResponseBody toResponseBody(UnitConverter unitConverter);

    List<UnitConverterResponseBody> toResponseBodyList(List<UnitConverter> unitConverterList);
}
