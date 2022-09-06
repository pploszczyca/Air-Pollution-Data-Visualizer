package pl.edu.agh.apdvbackend.mappers.field_parser;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.FieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

@Mapper(componentModel = "spring")
public interface FieldParserMapper {
    @Mapping(target = "id", ignore = true)
    FieldParser addRequestBodyToFieldParser(FieldParserRequestBody requestBody);

    @Mapping(target = "id", ignore = true)
    void updateFieldParserFromAddRequestBody(
            FieldParserRequestBody requestBody,
            @MappingTarget FieldParser fieldParser
    );
}
