package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;

@Component
@RequiredArgsConstructor
public class RemoveFieldImpl implements RemoveField {

    private final FieldRepository fieldRepository;

    @Override
    public void execute(Long fieldId) {
        fieldRepository.deleteById(fieldId);
    }
}
