package pl.edu.agh.apdvbackend.annotations.mappers;

import org.mapstruct.Mapping;

@Mapping(target = "fieldParserMap", expression = "java(fieldAndParserKeyListToMap(addEndpointRequestBody.fieldAndParserKeys()))")
public @interface FromAddRequestBodyToEndpointInfoAnnotation {
}
