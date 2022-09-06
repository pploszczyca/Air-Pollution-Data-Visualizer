package pl.edu.agh.apdvbackend.mappers.field;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.unit.UnitNameMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;

@Mapper(componentModel = "spring")
public abstract class FieldRequestBodyMapper {

    @Autowired
    protected UnitNameMapper unitNameMapper;

    @FieldMapping
    public abstract Field toField(FieldRequestBody requestBody);

    @FieldMapping
    public abstract void updateFieldBy(FieldRequestBody requestBody, @MappingTarget Field field);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "groupEndpoint", ignore = true)
    @Mapping(target = "unit", expression = "java(unitNameMapper.toUnit(requestBody.unitName()))")
    private @interface FieldMapping{
    }
}
