package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import pl.edu.agh.apdvbackend.controllers.field_parser.body_models.AddFieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.FieldParser;

@Mapper(componentModel = "spring")
public interface FieldParserMapper {
    FieldParser addRequestBodyToFieldParser(
            AddFieldParserRequestBody addFieldParserRequestBody);

    void updateFieldParserFromAddRequestBody(
            AddFieldParserRequestBody addFieldParserRequestBody,
            @MappingTarget FieldParser fieldParser);
}
