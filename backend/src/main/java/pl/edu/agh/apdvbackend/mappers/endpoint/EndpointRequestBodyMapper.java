package pl.edu.agh.apdvbackend.mappers.endpoint;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldAndParserKeyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public abstract class EndpointRequestBodyMapper {

    @Autowired
    protected FieldAndParserKeyMapper fieldAndParserKeyMapper;

    @RequestBodyMapping
    public abstract Endpoint toEndpoint(EndpointRequestBody requestBody);

    @RequestBodyMapping
    public abstract void updateEndpoint(
            EndpointRequestBody requestBody,
            @MappingTarget Endpoint endpoint
    );

    @Mapping(
            target = "fieldParserMap",
            expression = "java(fieldAndParserKeyMapper.toMap(requestBody.fieldAndParserKeys()))"
    )
    private @interface RequestBodyMapping {
    }
}
