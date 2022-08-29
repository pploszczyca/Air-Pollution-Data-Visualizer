package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldAndParserKeyMapper;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldParserMapMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

@Mapper(componentModel = "spring")
public abstract class EndpointMapper {

    @Autowired
    protected FieldAndParserKeyMapper fieldAndParserKeyMapper;

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
}
