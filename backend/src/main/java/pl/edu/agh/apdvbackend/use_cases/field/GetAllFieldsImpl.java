package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllFieldsImpl
        implements GetAllFields {

    private final ListUtilities listUtilities;

    private final FieldRepository fieldRepository;

    @Override
    public List<Field> execute() {
        return listUtilities.iterableToList(fieldRepository.findAll());
    }
}
