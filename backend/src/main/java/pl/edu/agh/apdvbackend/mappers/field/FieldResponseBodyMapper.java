package pl.edu.agh.apdvbackend.mappers.field;

import java.util.List;
import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldResponseBody;
import pl.edu.agh.apdvbackend.models.database.Field;

@Mapper(componentModel = "spring")
public interface FieldResponseBodyMapper {
    FieldResponseBody toResponseBody(Field field);

    List<FieldResponseBody> toResponseBodyList(List<Field> fields);
}
