package pl.edu.agh.apdvbackend.mappers.endpoint;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldAndParserKeyMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

@Mapper(componentModel = "spring")
public abstract class AddEndpointRequestBodyMapper {

    @Autowired
    protected FieldAndParserKeyMapper fieldAndParserKeyMapper;

    @RequestBodyMapping
    public abstract Endpoint toEndpoint(AddEndpointRequestBody requestBody);

    @RequestBodyMapping
    public abstract void updateEndpoint(
            AddEndpointRequestBody requestBody,
            @MappingTarget Endpoint endpoint
    );

    @Mapping(
            target = "fieldParserMap",
            expression = "java(fieldAndParserKeyMapper.toMap(requestBody.fieldAndParserKeys()))"
    )
    private @interface RequestBodyMapping {
    }
}
