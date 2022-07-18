package pl.edu.agh.apdvbackend.annotations.mappers;

import org.mapstruct.Mapping;

@Mapping(target = "fromUnit", expression = "java(getUnit(addUnitConverterRequestBody.fromUnitId()))")
@Mapping(target = "toUnit", expression = "java(getUnit(addUnitConverterRequestBody.toUnitId()))")
public @interface AddRequestBodyToUnitConverterAnnotation {
}
