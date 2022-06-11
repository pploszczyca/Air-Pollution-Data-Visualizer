package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.EndpointData;
import pl.edu.agh.apdvbackend.use_cases.enable_endpoints.GetEnableEndpointByUserAndEndpointId;

@Component
@RequiredArgsConstructor
public class GetUserEndpointDataWithFieldsImpl
        implements GetUserEndpointDataWithFields {

    private final GetUserEndpointData getUserEndpointData;

    private final GetEnableEndpointByUserAndEndpointId
            getEnableEndpointByUserAndEndpointId;

    @Override
    public EndpointData execute(Long userId, Long endpointId) {
        final var fields = getEnableEndpointByUserAndEndpointId
                .execute(userId, endpointId)
                .getEnableFields();
        final var endpointData =
                getUserEndpointData.execute(userId, endpointId);

        return new EndpointData(fields, endpointData);
    }
}
