package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.Endpoint;

@Mapper(componentModel = "spring")
public interface EndpointInfoMapper {
    Endpoint fromAddRequestBodyToEndpointInfo(
            AddEndpointRequestBody addEndpointRequestBody);
}
