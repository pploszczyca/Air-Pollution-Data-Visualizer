package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.EndpointData;
import pl.edu.agh.apdvbackend.use_cases.field.GetAllEnableFieldsForEndpointAndUser;

@Component
@RequiredArgsConstructor
public class GetUserEndpointDataWithFieldsImpl
        implements GetUserEndpointDataWithFields {

    private final GetUserEndpointData getUserEndpointData;

    private final GetAllEnableFieldsForEndpointAndUser getEnableFields;

    @Override
    public EndpointData execute(Long userId, Long endpointId) {
        final var fields = getEnableFields
                .execute(userId, endpointId);
        final var endpointData =
                getUserEndpointData.execute(userId, endpointId);

        return new EndpointData(fields, endpointData);
    }
}
