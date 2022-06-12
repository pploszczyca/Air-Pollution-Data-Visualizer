package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import pl.edu.agh.apdvbackend.models.Field;

public interface GetAllEnableFieldsForEndpointAndUser {
    List<Field> execute(Long userId, Long endpointId);
}
