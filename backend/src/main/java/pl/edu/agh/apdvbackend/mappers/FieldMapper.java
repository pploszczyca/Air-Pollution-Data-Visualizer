package pl.edu.agh.apdvbackend.mappers;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldWithoutId;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.use_cases.unit.SaveUnitByNameIfNotExist;

@Mapper(componentModel = "spring")
public abstract class FieldMapper {

    private static final String UNIT = "unit";

    private static final String UNIT_MAPPING_EXPRESSION =
            "java(saveUnitByNameIfNotExist.execute(addFieldBodyRequest.unitName()))";

    @Autowired
    protected SaveUnitByNameIfNotExist saveUnitByNameIfNotExist;

    @Mapping(target = UNIT, expression = UNIT_MAPPING_EXPRESSION)
    public abstract Field addRequestBodyToField(
            AddFieldBodyRequest addFieldBodyRequest);

    @Mapping(target = UNIT, expression = UNIT_MAPPING_EXPRESSION)
    public abstract void updateFieldFromAddRequestBody(
            AddFieldBodyRequest addFieldBodyRequest,
            @MappingTarget Field field);

    public abstract FieldWithoutId fieldToWithoutId(Field field);

    public abstract List<FieldWithoutId> fieldListToWithoutIdList(
            List<Field> fields);
}
