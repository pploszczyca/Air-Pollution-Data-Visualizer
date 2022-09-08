package pl.edu.agh.apdvbackend.mappers.field;

import java.util.List;
import org.mapstruct.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;

@Mapper(componentModel = "spring")
public abstract class IdsToFieldsMapper {

    @Autowired
    private GetField getField;

    public List<Field> toFields(List<Long> fieldIds) {
        return fieldIds
                .stream()
                .map(getField::execute)
                .toList();
    }
}
