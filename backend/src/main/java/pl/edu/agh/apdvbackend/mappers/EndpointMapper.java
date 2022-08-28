package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import java.util.Map;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldAndParserKeyMapper;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldAndParserMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointSummaryResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParser;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

@Mapper(componentModel = "spring")
public abstract class EndpointMapper {

    @Autowired
    protected FieldAndParserKeyMapper fieldAndParserKeyMapper;

    @Autowired
    private FieldAndParserMapper fieldAndParserMapper;

    @Mapping(
            target = "fieldParserMap",
            expression = "java(fieldAndParserKeyMapper.toMap(requestBody.fieldAndParserKeys()))"
    )
    public abstract Endpoint fromAddRequestBodyToEndpointInfo(AddEndpointRequestBody requestBody);

    @Mapping(
            target = "fieldParserMap",
            expression = "java(fieldAndParserKeyMapper.toMap(requestBody.fieldAndParserKeys()))"
    )
    public abstract void updateEndpointFromAddRequestBody(
            AddEndpointRequestBody requestBody,
            @MappingTarget Endpoint endpoint
    );

    public abstract UserEndpointResponseBody endpointToUserEndpointResponseBody(
            Endpoint endpoint);

    public abstract List<UserEndpointResponseBody> endpointListToUserEndpointResponseBodyList(
            List<Endpoint> endpoints);

    @Mapping(target = "fieldAndParserList", expression = "java(fieldAndParserMapToList(endpoint.getFieldParserMap()))")
    public abstract EndpointSummaryResponseBody endpointToSummaryResponseBody(
            Endpoint endpoint);

    public abstract List<EndpointSummaryResponseBody> endpointListToSummaryResponseBodyList(
            List<Endpoint> endpoints);

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
