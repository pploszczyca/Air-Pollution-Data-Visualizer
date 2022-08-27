package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.FieldMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;

@Component
@RequiredArgsConstructor
public class UpdateFieldImpl implements UpdateField {

    private final FieldRepository fieldRepository;
    private final FieldMapper fieldMapper;

    @Override
    public Field execute(
            Long fieldId,
            AddFieldRequestBody addFieldRequestBody
    ) {
        final var updatingField = fieldRepository
                .findById(fieldId)
                .orElseThrow();

        fieldMapper.updateFieldFromAddRequestBody(addFieldRequestBody, updatingField);

        return fieldRepository.save(updatingField);
    }
}
