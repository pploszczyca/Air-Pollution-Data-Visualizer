package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field.AddFieldRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;
import pl.edu.agh.apdvbackend.use_cases.unit.SaveUnitByNameIfNotExist;

@Component
@RequiredArgsConstructor
public class SaveNewFieldImpl implements SaveNewField {

    private final FieldRepository fieldRepository;
    private final SaveUnitByNameIfNotExist saveUnitByNameIfNotExist;
    private final AddFieldRequestBodyMapper mapper;

    @Override
    public Field execute(AddFieldRequestBody requestBody) {
        requestBody.unitName().ifPresent(saveUnitByNameIfNotExist::execute);

        return fieldRepository.save(mapper.toField(requestBody));
    }
}
