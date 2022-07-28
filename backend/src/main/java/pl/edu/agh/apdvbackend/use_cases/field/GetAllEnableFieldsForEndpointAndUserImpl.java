package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.use_cases.enable_endpoints.GetEndpointDataForUser;

@Component
@RequiredArgsConstructor
public class GetAllEnableFieldsForEndpointAndUserImpl
        implements GetAllEnableFieldsForEndpointAndUser {

    private final GetEndpointDataForUser getEndpointDataForUser;

    @Override
    public List<Field> execute(Long userId, Long endpointId) {
        return getEndpointDataForUser
                .execute(userId, endpointId)
                .enableFields();
    }
}
