package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.EndpointInfo;
import pl.edu.agh.apdvbackend.models.body_models.sensors.AddEndpointRequestBody;

@Mapper(componentModel = "spring")
public interface EndpointInfoMapper {
    EndpointInfo fromAddRequestBodyToEndpointInfo(
            AddEndpointRequestBody addEndpointRequestBody);
}
