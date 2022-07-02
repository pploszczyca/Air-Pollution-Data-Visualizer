package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParser;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

@Mapper(componentModel = "spring")
public interface FieldAndParserMapper {
    @Mapping(target = "fieldId", source = "field.id")
    @Mapping(target = "parserId", source = "fieldParser.id")
    FieldAndParser combineFieldAndParser(Field field, FieldParser fieldParser);
}
