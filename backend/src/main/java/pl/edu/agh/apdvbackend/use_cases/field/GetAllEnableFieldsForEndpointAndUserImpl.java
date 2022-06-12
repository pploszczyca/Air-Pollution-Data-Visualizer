package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.Field;
import pl.edu.agh.apdvbackend.use_cases.enable_endpoints.GetEnableEndpointByUserAndEndpointId;

@Component
@RequiredArgsConstructor
public class GetAllEnableFieldsForEndpointAndUserImpl
        implements GetAllEnableFieldsForEndpointAndUser {

    private final GetEnableEndpointByUserAndEndpointId
            getEnableEndpointByUserAndEndpointId;

    @Override
    public List<Field> execute(Long userId, Long endpointId) {
        return getEnableEndpointByUserAndEndpointId
                .execute(userId, endpointId)
                .getEnableFields();
    }
}
