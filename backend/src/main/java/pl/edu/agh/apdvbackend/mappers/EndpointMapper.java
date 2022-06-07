package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.FieldAndParserKey;
import pl.edu.agh.apdvbackend.models.Endpoint;
import pl.edu.agh.apdvbackend.models.Field;
import pl.edu.agh.apdvbackend.models.FieldParser;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;
import pl.edu.agh.apdvbackend.use_cases.field_parser.GetFieldParser;

@Mapper(componentModel = "spring")
public abstract class EndpointMapper {

    private static final String FIELD_PARSER_MAP_TARGET = "fieldParserMap";

    private static final String FIELD_PARSER_MAP_EXPRESSION =
            "java(fieldAndParserKeyListToMap(addEndpointRequestBody.fieldAndParserKeys()))";

    @Autowired
    private GetField getField;

    @Autowired
    private GetFieldParser getFieldParser;

    @Mapping(target = FIELD_PARSER_MAP_TARGET, expression = FIELD_PARSER_MAP_EXPRESSION)
    public abstract Endpoint fromAddRequestBodyToEndpointInfo(
            AddEndpointRequestBody addEndpointRequestBody);

    @Mapping(target = FIELD_PARSER_MAP_TARGET, expression = FIELD_PARSER_MAP_EXPRESSION)
    public abstract void updateEndpointFromAddRequestBody(
            AddEndpointRequestBody addEndpointRequestBody,
            @MappingTarget Endpoint endpoint);

    protected Map<Field, FieldParser> fieldAndParserKeyListToMap(
            List<FieldAndParserKey> fieldAndParserKeys) {
        return fieldAndParserKeys
                .stream()
                .collect(Collectors
                        .toMap(item -> getField.execute(item.fieldId()),
                                item -> getFieldParser.execute(
                                        item.fieldId())));
    }
}
