package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.AddFieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

@Mapper(componentModel = "spring")
public interface FieldParserMapper {
    FieldParser addRequestBodyToFieldParser(
            AddFieldParserRequestBody addFieldParserRequestBody);

    void updateFieldParserFromAddRequestBody(
            AddFieldParserRequestBody addFieldParserRequestBody,
            @MappingTarget FieldParser fieldParser);
}
