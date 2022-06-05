package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import pl.edu.agh.apdvbackend.controllers.field.body_models.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.Field;

@Mapper(componentModel = "spring")
public interface FieldMapper {
    @Mapping(source = "addFieldBodyRequest.label", target = "label")
    Field addRequestBodyToField(AddFieldBodyRequest addFieldBodyRequest);

    @Mapping(source = "addFieldBodyRequest.label", target = "label")
    void updateFieldFromAddRequestBody(AddFieldBodyRequest addFieldBodyRequest, @MappingTarget Field field);
}
