package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field.FieldRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;
import pl.edu.agh.apdvbackend.use_cases.unit.SaveUnitByNameIfNotExist;

@Component
@RequiredArgsConstructor
public class SaveNewFieldImpl implements SaveNewField {

    private final FieldRepository fieldRepository;
    private final SaveUnitByNameIfNotExist saveUnitByNameIfNotExist;
    private final FieldRequestBodyMapper mapper;

    @Override
    public Field execute(FieldRequestBody requestBody) {
        requestBody.unitName().ifPresent(saveUnitByNameIfNotExist::execute);

        return fieldRepository.save(mapper.toField(requestBody));
    }
}
