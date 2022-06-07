package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.FieldAndParser;
import pl.edu.agh.apdvbackend.models.Field;
import pl.edu.agh.apdvbackend.models.FieldParser;

@Mapper(componentModel = "spring")
public interface FieldAndParserMapper {
    @Mapping(target = "fieldId", source = "field.id")
    @Mapping(target = "parserId", source = "fieldParser.id")
    FieldAndParser combineFieldAndParser(Field field, FieldParser fieldParser);
}
