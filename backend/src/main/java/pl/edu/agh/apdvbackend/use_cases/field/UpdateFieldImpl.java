package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field.add_request_body.AddFieldRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;
import pl.edu.agh.apdvbackend.use_cases.unit.SaveUnitByNameIfNotExist;

@Component
@RequiredArgsConstructor
public class UpdateFieldImpl implements UpdateField {

    private final FieldRepository fieldRepository;
    private final SaveUnitByNameIfNotExist saveUnitByNameIfNotExist;
    private final AddFieldRequestBodyMapper mapper;

    @Override
    public Field execute(
            Long fieldId,
            AddFieldRequestBody addFieldRequestBody
    ) {
        final var updatingField = fieldRepository
                .findById(fieldId)
                .orElseThrow();

        addFieldRequestBody.unitName().ifPresent(saveUnitByNameIfNotExist::execute);
        mapper.updateFieldBy(addFieldRequestBody, updatingField);

        return fieldRepository.save(updatingField);
    }
}
