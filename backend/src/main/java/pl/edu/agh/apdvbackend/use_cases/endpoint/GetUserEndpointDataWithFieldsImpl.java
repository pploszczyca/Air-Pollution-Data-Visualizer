package pl.edu.agh.apdvbackend.use_cases.endpoint;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.FieldMapper;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointWithField;
import pl.edu.agh.apdvbackend.use_cases.field.GetAllEnableFieldsForEndpointAndUser;

@Component
@RequiredArgsConstructor
public class GetUserEndpointDataWithFieldsImpl implements GetUserEndpointDataWithFields {

    private final GetUserEndpointData getUserEndpointData;
    private final GetAllEnableFieldsForEndpointAndUser getEnableFields;
    private final FieldMapper fieldMapper;

    @Override
    public EndpointWithField execute(
            Long userId,
            Long endpointId,
            Long limit,
            Long offset
    ) {
        final var fields = getEnableFields.execute(userId, endpointId);
        final var fieldsWithoutId = fieldMapper.fieldListToWithoutIdList(fields);
        final var endpointData = getUserEndpointData.execute(userId, endpointId, limit, offset);

        return new EndpointWithField(fieldsWithoutId, endpointData);
    }
}
