package pl.edu.agh.apdvbackend.mappers.field;

import java.util.List;
import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldWithoutId;
import pl.edu.agh.apdvbackend.models.database.Field;

@Mapper(componentModel = "spring")
public abstract class FieldWithoutIdMapper {

    public abstract FieldWithoutId fieldToWithoutId(Field field);

    public abstract List<FieldWithoutId> fieldsToWithoutIdList(List<Field> fields);
}
