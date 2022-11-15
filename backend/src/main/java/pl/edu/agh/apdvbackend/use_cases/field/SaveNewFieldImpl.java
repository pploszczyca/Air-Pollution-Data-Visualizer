package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field.FieldRequestBodyMapper;
import pl.edu.agh.apdvbackend.mappers.field.FieldResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldResponseBody;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;
import pl.edu.agh.apdvbackend.use_cases.unit.SaveUnitByNameIfNotExist;

@Component
@RequiredArgsConstructor
public class SaveNewFieldImpl implements SaveNewField {

    private final FieldRepository fieldRepository;
    private final SaveUnitByNameIfNotExist saveUnitByNameIfNotExist;
    private final FieldRequestBodyMapper mapper;
    private final FieldResponseBodyMapper fieldResponseBodyMapper;

    @Override
    public FieldResponseBody execute(FieldRequestBody requestBody) {
        requestBody.unitName().ifPresent(saveUnitByNameIfNotExist::execute);

        final var savedField = fieldRepository.save(mapper.toField(requestBody));
        return fieldResponseBodyMapper.toResponseBody(savedField);
    }
}
