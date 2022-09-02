package pl.edu.agh.apdvbackend.mappers.endpoint;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldParserMapMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParser;
import pl.edu.agh.apdvbackend.models.database.Endpoint;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public abstract class EndpointResponseBodyMapper {

    @Autowired
    private FieldParserMapMapper fieldParserMapMapper;

    @Mapping(target = "fieldAndParserList", expression = "java(mapFieldParserMap(endpoint))")
    public abstract EndpointResponseBody toResponseBody(Endpoint endpoint);

    public abstract List<EndpointResponseBody> toResponseBodyList(List<Endpoint> endpoints);

    protected List<FieldAndParser> mapFieldParserMap(Endpoint endpoint) {
        return fieldParserMapMapper.toFieldAndParserList(endpoint.getFieldParserMap());
    }
}
