package pl.edu.agh.apdvbackend.mappers.field.add_request_body;

import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import pl.edu.agh.apdvbackend.annotations.mappers.AddRequestBodyToFieldAnnotation;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;

@Mapper(componentModel = "spring")
public interface AddFieldRequestBodyMapper {
    @AddRequestBodyToFieldAnnotation
    Field toField(AddFieldRequestBody addFieldRequestBody);

    @AddRequestBodyToFieldAnnotation
    void updateFieldBy(AddFieldRequestBody addFieldRequestBody, @MappingTarget Field field);
}
