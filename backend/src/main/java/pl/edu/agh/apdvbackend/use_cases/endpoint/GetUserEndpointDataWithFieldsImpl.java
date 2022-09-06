package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field.FieldWithoutIdMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointWithField;
import pl.edu.agh.apdvbackend.use_cases.field.GetAllEnableFieldsForEndpointAndUser;

@Component
@RequiredArgsConstructor
public class GetUserEndpointDataWithFieldsImpl implements GetUserEndpointDataWithFields {

    private final GetUserEndpointData getUserEndpointData;
    private final GetAllEnableFieldsForEndpointAndUser getEnableFields;
    private final FieldWithoutIdMapper fieldWithoutIdMapper;

    @Override
    public EndpointWithField execute(
            Long userId,
            Long endpointId,
            Long limit,
            Long offset
    ) {
        final var fields = getEnableFields.execute(userId, endpointId);
        final var fieldsWithoutId = fieldWithoutIdMapper.fieldsToWithoutIdList(fields);
        final var endpointData = getUserEndpointData.execute(userId, endpointId, limit, offset);

        return new EndpointWithField(fieldsWithoutId, endpointData);
    }
}
