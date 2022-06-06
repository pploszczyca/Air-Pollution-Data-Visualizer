package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.Endpoint;

@Mapper(componentModel = "spring")
public interface EndpointMapper {
    Endpoint fromAddRequestBodyToEndpointInfo(
            AddEndpointRequestBody addEndpointRequestBody);

    void updateEndpointFromAddRequestBody(AddEndpointRequestBody addEndpointRequestBody, @MappingTarget Endpoint endpoint);
}
