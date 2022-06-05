package pl.edu.agh.apdvbackend.mappers;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.controllers.field.body_models.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.Field;

@Mapper(componentModel = "spring")
public interface FieldMapper {
    Field AddRequestBodyToField(AddFieldBodyRequest addFieldBodyRequest);
}
