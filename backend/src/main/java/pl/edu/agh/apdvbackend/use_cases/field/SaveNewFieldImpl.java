package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field.add_request_body.AddFieldRequestBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldRequestBody;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;

@Component
@RequiredArgsConstructor
public class SaveNewFieldImpl implements SaveNewField {

    private final FieldRepository fieldRepository;
    private final AddFieldRequestBodyMapper mapper;

    @Override
    public Field execute(AddFieldRequestBody addFieldRequestBody) {
        return fieldRepository.save(
                mapper.toField(addFieldRequestBody)
        );
    }
}
