package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllEnableFieldsForEndpointAndUserImpl implements GetAllEnableFieldsForEndpointAndUser {

    private final FieldRepository fieldRepository;
    private final ListUtilities listUtilities;

    @Override
    public List<Field> execute(Long userId, Long endpointId) {
        return listUtilities.iterableToList(
                fieldRepository.findAllThatAreEnable(userId, endpointId)
        );
    }
}
