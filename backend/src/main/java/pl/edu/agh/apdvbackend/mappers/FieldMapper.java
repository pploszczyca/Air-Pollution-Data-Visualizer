package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import pl.edu.agh.apdvbackend.annotations.mappers.AddRequestBodyToFieldAnnotation;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldWithoutId;
import pl.edu.agh.apdvbackend.models.database.Field;

@Mapper(componentModel = "spring")
public abstract class FieldMapper {

    @AddRequestBodyToFieldAnnotation
    public abstract Field addRequestBodyToField(
            AddFieldRequestBody addFieldRequestBody);

    @AddRequestBodyToFieldAnnotation
    public abstract void updateFieldFromAddRequestBody(
            AddFieldRequestBody addFieldRequestBody,
            @MappingTarget Field field);

    public abstract FieldWithoutId fieldToWithoutId(Field field);

    public abstract List<FieldWithoutId> fieldListToWithoutIdList(
            List<Field> fields);
}
