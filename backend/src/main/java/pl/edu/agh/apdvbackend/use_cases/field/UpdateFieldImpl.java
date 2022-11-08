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
public class UpdateFieldImpl implements UpdateField {

    private final FieldRepository fieldRepository;
    private final SaveUnitByNameIfNotExist saveUnitByNameIfNotExist;
    private final FieldRequestBodyMapper mapper;
    private final FieldResponseBodyMapper fieldResponseBodyMapper;

    @Override
    public FieldResponseBody execute(
            Long fieldId,
            FieldRequestBody fieldRequestBody
    ) {
        final var updatingField = fieldRepository
                .findById(fieldId)
                .orElseThrow();

        fieldRequestBody.unitName().ifPresent(saveUnitByNameIfNotExist::execute);
        mapper.updateFieldBy(fieldRequestBody, updatingField);

        return fieldResponseBodyMapper.toResponseBody(fieldRepository.save(updatingField));
    }
}
