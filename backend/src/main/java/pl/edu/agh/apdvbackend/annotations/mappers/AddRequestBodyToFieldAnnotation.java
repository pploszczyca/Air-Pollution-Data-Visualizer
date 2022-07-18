package pl.edu.agh.apdvbackend.annotations.mappers;

import org.mapstruct.Mapping;

@Mapping(target = "unit", expression = "java(saveUnitByNameIfNotExist.execute(addFieldBodyRequest.unitName()))")
public @interface AddRequestBodyToFieldAnnotation {
}
