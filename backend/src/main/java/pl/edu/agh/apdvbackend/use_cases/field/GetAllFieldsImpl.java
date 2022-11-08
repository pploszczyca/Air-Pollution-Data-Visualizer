package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field.FieldResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldResponseBody;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllFieldsImpl
        implements GetAllFields {

    private final ListUtilities listUtilities;
    private final FieldRepository fieldRepository;
    private final FieldResponseBodyMapper fieldResponseBodyMapper;

    @Override
    public List<FieldResponseBody> execute() {
        final var fields = listUtilities.iterableToList(fieldRepository.findAll());
        return fieldResponseBodyMapper.toResponseBodyList(fields);
    }
}
