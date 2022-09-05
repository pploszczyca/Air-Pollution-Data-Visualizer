package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.FieldMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;

@Component
@RequiredArgsConstructor
public class SaveNewFieldImpl implements SaveNewField {

    private final FieldRepository fieldRepository;
    private final FieldMapper fieldMapper;

    @Override
    public Field execute(AddFieldBodyRequest addFieldBodyRequest) {
        return fieldRepository.save(
                fieldMapper.addRequestBodyToField(addFieldBodyRequest)
        );
    }
}
