package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.EndpointData;
import pl.edu.agh.apdvbackend.mappers.FieldMapper;
import pl.edu.agh.apdvbackend.use_cases.field.GetAllEnableFieldsForEndpointAndUser;

@Component
@RequiredArgsConstructor
public class GetUserEndpointDataWithFieldsImpl
        implements GetUserEndpointDataWithFields {

    private final GetUserEndpointData getUserEndpointData;

    private final GetAllEnableFieldsForEndpointAndUser getEnableFields;

    private final FieldMapper fieldMapper;

    @Override
    public EndpointData execute(Long userId, Long endpointId) {
        final var fields = getEnableFields
                .execute(userId, endpointId);
        final var fieldsWithoutId =
                fieldMapper.fieldListToWithoutIdList(fields);
        final var endpointData =
                getUserEndpointData.execute(userId, endpointId);

        return new EndpointData(fieldsWithoutId, endpointData);
    }
}
