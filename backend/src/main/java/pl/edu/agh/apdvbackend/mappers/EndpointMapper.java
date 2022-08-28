package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.annotations.mappers.FromAddRequestBodyToEndpointInfoAnnotation;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldAndParserMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointSummaryResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParser;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParserKey;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;
import pl.edu.agh.apdvbackend.use_cases.field_parser.GetFieldParser;

@Mapper(componentModel = "spring")
public abstract class EndpointMapper {

    @Autowired
    private GetField getField;

    @Autowired
    private GetFieldParser getFieldParser;

    @Autowired
    private FieldAndParserMapper fieldAndParserMapper;

    @FromAddRequestBodyToEndpointInfoAnnotation
    public abstract Endpoint fromAddRequestBodyToEndpointInfo(
            AddEndpointRequestBody addEndpointRequestBody);

    @FromAddRequestBodyToEndpointInfoAnnotation
    public abstract void updateEndpointFromAddRequestBody(
            AddEndpointRequestBody addEndpointRequestBody,
            @MappingTarget Endpoint endpoint);

    public abstract UserEndpointResponseBody endpointToUserEndpointResponseBody(
            Endpoint endpoint);

    public abstract List<UserEndpointResponseBody> endpointListToUserEndpointResponseBodyList(
            List<Endpoint> endpoints);

    @Mapping(target = "fieldAndParserList", expression = "java(fieldAndParserMapToList(endpoint.getFieldParserMap()))")
    public abstract EndpointSummaryResponseBody endpointToSummaryResponseBody(
            Endpoint endpoint);

    public abstract List<EndpointSummaryResponseBody> endpointListToSummaryResponseBodyList(
            List<Endpoint> endpoints);

    protected Map<Field, FieldParser> fieldAndParserKeyListToMap(
            List<FieldAndParserKey> fieldAndParserKeys) {
        return fieldAndParserKeys
                .stream()
                .collect(Collectors
                        .toMap(item -> getField.execute(item.fieldId()),
                                item -> getFieldParser.execute(
                                        item.fieldId())));
    }

    protected List<FieldAndParser> fieldAndParserMapToList(
            Map<Field, FieldParser> fieldParserMap) {
        return fieldParserMap
                .entrySet()
                .stream()
                .map(fieldFieldParserEntry -> fieldAndParserMapper.combineFieldAndParser(
                        fieldFieldParserEntry.getKey(),
                        fieldFieldParserEntry.getValue()))
                .toList();
    }
}
