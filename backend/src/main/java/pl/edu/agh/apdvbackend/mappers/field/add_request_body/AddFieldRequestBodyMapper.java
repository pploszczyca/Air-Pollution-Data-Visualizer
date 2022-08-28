package pl.edu.agh.apdvbackend.mappers.field.add_request_body;

import java.util.Optional;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.unit.UnitNameMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.Unit;

@Mapper(componentModel = "spring")
public abstract class AddFieldRequestBodyMapper {

    @Autowired
    private UnitNameMapper unitNameMapper;

    @Mapping(target = "unit", expression = "java(toUnit(requestBody.unitName()))")
    public abstract Field toField(AddFieldRequestBody requestBody);

    @Mapping(target = "unit", expression = "java(toUnit(requestBody.unitName()))")
    public abstract void updateFieldBy(AddFieldRequestBody requestBody, @MappingTarget Field field);

    protected Unit toUnit(Optional<String> unitName) {
        return unitName
                .map(s -> unitNameMapper.toUnit(s))
                .orElse(null);
    }
}
