package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;

@Component
@RequiredArgsConstructor
public class GetFieldImpl
        implements GetField {

    private final FieldRepository fieldRepository;

    @Override
    public Field execute(Long fieldId) {
        return fieldRepository.findById(fieldId).orElseThrow();
    }
}
